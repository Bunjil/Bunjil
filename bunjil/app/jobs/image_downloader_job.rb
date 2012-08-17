require 'open-uri'

class ImageDownloaderJob

  NUMBER_OF_THREADS = 2
  NUMBER_OF_RETRIES = 3
  IMAGE_PATH = ""

  def perform
    threads = []


    download_tasks = AreaUpdateDownloadTask.find(:all, :limit => NUMBER_OF_THREADS)
    while(download_tasks.count > 0)

      # checks to see if there are any download task and to skip if there aren't any.
      download_tasks.each do |download_task|
        threads << Thread.new(download_task){
          # to get the name of the image from the url.
          #image_name = download_task.area_update.area_update_id
          image_url = download_task.image_url_band_3
          image_name = download_task.image_url_band_3.split('/').last
          # log downloading image
          log_downloading_image(image_name, image_url)

          begin
            open("#{IMAGE_PATH}#{image_name}", 'wb') do |file|
              file << open(image_url).read
            end
            #log download success
            log_download_success(image_name, image_url)
            # Delete task once image is downloaded
            AreaUpdateDownloadTask.destroy(download_task)
          rescue Exception => e
            log_download_fail(image_name, image_url, e.message)

            download_task.retries += 1
            download_task.save
            if(download_task.retries >= NUMBER_OF_RETRIES)

              File.delete("#{IMAGE_PATH}#{image_name}")
              AreaUpdateDownloadTask.destroy(download_task)
            end
          end
        }
      end
      threads.each { |aThread|  aThread.join }
      download_tasks = AreaUpdateDownloadTask.find(:all, :limit => NUMBER_OF_THREADS)
    end


    # move on to next task (nil if none).
    #download_tasks = AreaUpdateDownloadTask.first()
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
