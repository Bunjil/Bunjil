image_download_logfile = File.open("#{Rails.root}/log/ImageDownloader.log", 'a')
image_download_logfile.sync = true #flush data to file straight away
IMAGE_DOWNLOAD_LOG = ImageDownloadLogger.new(image_download_logfile)