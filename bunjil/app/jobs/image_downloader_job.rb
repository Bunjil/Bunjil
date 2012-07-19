require 'open-uri'

class ImageDownloaderJob

  def perform
    download_task = AreaUpdateDownloadTask.first()
    # checks to see if there are any download task and to skip if there aren't any.
    while ( !download_task.nil?)
      # to get the name of the image from the url.
      image_name = download_task.image_url.split('/').last

      log_downloading_image(image_name, download_task.image_url)

      open(image_name, 'wb') do |file|
        file << open(download_task.image_url).read
      end

      log_download_success(image_name, download_task.image_url)
      # Delete task once image is downloaded
      AreaUpdateDownloadTask.destroy(download_task)
      # move on to next task (nil if none).
      download_task = AreaUpdateDownloadTask.first()
    end
  end

  def image_logger
    @@image_logger ||= Logger.new("#{Rails.root}/log/ImageDownloader.log")
  end

  def log_downloading_image(name, url)
    image_logger.info("Downloading #{name} from #{url}")
  end
  def log_download_success(name, url)
    image_logger.info("Downloaded #{name} from #{url}")
  end
  def log_download_fail(name, url)
    image_logger.info("Failed to download #{name} from #{url}")
  end


end
