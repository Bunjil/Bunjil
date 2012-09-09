require 'open-uri'
require 'rubygems/package'
require 'zlib'
require 'fileutils'
require 'net/https'
require 'net/http'
require 'mechanize'

class ImageDownloaderJob

  NUMBER_OF_THREADS = 2
  NUMBER_OF_RETRIES = 3
  ARCHIVE_PATH = ""
  IMAGE_PATH =""

  def perform
    threads = []


    download_tasks = AreaUpdateDownloadTask.find(:all, :limit => NUMBER_OF_THREADS)
    while(download_tasks.count > 0)

      # checks to see if there are any download task and to skip if there aren't any.
      download_tasks.each do |download_task|
        threads << Thread.new(download_task){
          # to get the name of the image from the url.
          #archive_name = download_task.area_update.area_update_id

          archive_name = download_task.area_update.id
          # log downloading image
          log_downloading_image(archive_name)
          archive_file = "#{ARCHIVE_PATH}#{archive_name}"
          begin
            download_from_earth_explorer(archive_name)
            #log download success
            log_download_success(archive_name)
            # Delete task once image is downloaded
            AreaUpdateDownloadTask.destroy(download_task)

          rescue Exception => e
            log_download_fail(archive_name, e.message)

            download_task.retries += 1
            download_task.save
            if(download_task.retries >= NUMBER_OF_RETRIES)

              File.delete("#{ARCHIVE_PATH}#{archive_name}")
              AreaUpdateDownloadTask.destroy(download_task)
            end
          end

          extract_tiffs("#{IMAGE_PATH}",archive_file)
          perform_ndvi(archive_name,download_task.area_update)
        }
      end
      threads.each { |aThread|  aThread.join }
      download_tasks = AreaUpdateDownloadTask.find(:all, :limit => NUMBER_OF_THREADS)
    end


    # move on to next task (nil if none).
    #download_tasks = AreaUpdateDownloadTask.first()
  end


  def extract_tiffs(image_id)
    archive_file = "#{ARCHIVE_PATH}#{image_id}"
    reader = Gem::Package::TarReader.new(Zlib::GzipReader.open(archive_file))
    reader.each do |entry|
      if (entry.full_name == image_id+'_B3.TIF') or (entry.full_name == image_id+'_B4.TIF') 
        # puts entry.full_name
        open("#{IMAGE_PATH}#{entry.full_name}", 'wb') do |file|
          file << entry.read
        end
      end 
    end   
    FileUtils.rm(archive_file) 
  end



  def download_from_earth_explorer(image_id)
    agent = Mechanize.new
    page = agent.get('https://earthexplorer.usgs.gov/login')
    login_form = page.forms[0]
    login_form.username = 'bunjil'
    login_form.password = 'Batman2012'
    agent.submit(login_form)
    agent.pluggable_parser.default = Mechanize::Download
    # agent.max_file_buffer = 100
    # agent.get("http://earthexplorer.usgs.gov/download/3373/LE71290232012244EDC00/STANDARD//").save('image_id')
    agent.get("http://earthexplorer.usgs.gov/download/3373/#{image_id}/STANDARD//").save(image_id)
    # agent.progressbar{ agent.download("http://earthexplorer.usgs.gov/download/3373/#{image_id}/STANDARD//",image_id)}

  end

  def perform_ndvi(image_id, area_update)
    ImageProcessorJob.new.perform(area_update,"#{IMAGE_PATH}#{image_id}_B3.TIF","#{IMAGE_PATH}#{image_id}_B4.TIF")
  end

  def log_downloading_image(name)
    IMAGE_DOWNLOAD_LOG.info("Downloading #{name} from Earth Explorer")
  end
  def log_download_success(name)
    IMAGE_DOWNLOAD_LOG.info("Downloaded #{name} from  Earth Explorer")
  end
  def log_download_fail(name, message)
    IMAGE_DOWNLOAD_LOG.error("Failed to download #{name} from Earth Explorer \n\t #{message}")
  end


end
