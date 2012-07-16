require 'open-uri'

class ImageDownloaderJob

  def perform
    download_task = AreaUpdateDownloadTask.first()
    # checks to see if there are any download task and to skip if there aren't any.
    while ( not download_task.nil?) 
      # to get the name of the image from the url.
      image_name = download_task.image_url.split('/').last
      puts "downloading " << image_name
      open(image_name, 'wb') do |file|
        file << open(download_task.image_url).read
      end
    # Delete task once image is downloaded
    AreaUpdateDownloadTask.destroy(download_task)
    # move on to next task (nil if none).
    download_task = AreaUpdateDownloadTask.first()
    end
  end
end
