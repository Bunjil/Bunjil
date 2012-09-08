require 'open-uri'
require 'rubygems/package'
require 'zlib'


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
          archive_url = IMAGE_BASE_URL.sub("${IMAGE_ID}",archive_name)
          # log downloading image
          log_downloading_image(archive_name, archive_url)
          archive_file = "#{ARCHIVE_PATH}#{archive_name}"
          begin
            open(archive_file, 'wb') do |file|
              file << open(archive_url).read
            end
            #log download success
            log_download_success(archive_name, archive_url)
            # Delete task once image is downloaded
            AreaUpdateDownloadTask.destroy(download_task)

          rescue Exception => e
            log_download_fail(archive_name, archive_url, e.message)

            download_task.retries += 1
            download_task.save
            if(download_task.retries >= NUMBER_OF_RETRIES)

              File.delete("#{ARCHIVE_PATH}#{archive_name}")
              AreaUpdateDownloadTask.destroy(download_task)
            end
          end

          extract_tiffs("#{IMAGE_PATH}",archive_file)
        }
      end
      threads.each { |aThread|  aThread.join }
      download_tasks = AreaUpdateDownloadTask.find(:all, :limit => NUMBER_OF_THREADS)
    end


    # move on to next task (nil if none).
    #download_tasks = AreaUpdateDownloadTask.first()
  end


  def extract_tiffs(image_path, image_id)
    reader = Gem::Package::TarReader.new(Zlib::GzipReader.open(image_id))
    reader.each do |entry|
      if (entry.full_name == image_id+'_B3.TIF') or (entry.full_name == image_id+'_B4.TIF') 
        puts entry.full_name
        open("#{image_path}#{entry.full_name}", 'wb') do |file|
          file << entry.read
        end
      end 

      # puts entry.read
    end    
  end

  def log_downloading_image(name, url)
    IMAGE_DOWNLOAD_LOG.info("Downloading #{name} from #{url}")
  end
  def log_download_success(name, url)
    IMAGE_DOWNLOAD_LOG.info("Downloaded #{name} from #{url}")
  end
  def log_download_fail(name, url, message)
    IMAGE_DOWNLOAD_LOG.error("Failed to download #{name} from #{url} \n\t #{message}")
  end


end
