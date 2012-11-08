class StaticController < ApplicationController

  def job_dash
    # get the tasks for each job.
    @tasks = {}
    #@tasks[:item] = FeedItem.all
    @tasks[:inte] = AreaUpdate.where(has_been_intersection_checked: false)
    @tasks[:down] = AreaUpdateDownloadTask.all
    @tasks[:proc] = ImageProcessorTask.all
  end
  def index
  end

end