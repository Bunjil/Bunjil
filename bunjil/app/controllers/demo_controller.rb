class DemoController < ApplicationController

  # run all jobs
  def start
    LandsatRssReaderJob.new.perform(-1, true)

    flash[:success] = "Job's complete." 
    redirect_to '/'
  end

  def clear
    FeedItem.destroy_all #will delete all associated tasks.
    redirect_to '/job_dash'
  end
  def clear_feed
    redirect_to '/job_dash'
  end
  def rss
    items = params[:items][:items].to_i
    logger.debug "** ITEMS IN RSS JOB: " + params[:items][:items].to_s
    LandsatRssReaderJob.new.perform(items, false)
    flash[:success] = "Job's complete for #{params[:items][:items]}"  
    redirect_to '/job_dash'
  end

  def intersection_check
    IntersectionCheckingJob.new.call
    flash[:success] = "Job's complete." 
    redirect_to '/job_dash'
  end

  def downloader
    ImageDownloaderJob.new.perform
    flash[:success] = "Job's complete." 
    redirect_to '/job_dash'
  end

  def processor
    ImageProcessorJob.new.perform
    flash[:success] = "Job's complete." 
    redirect_to '/job_dash'
  end

end