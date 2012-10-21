class DemoController < ApplicationController

  def start
    LandsatRssReaderJob.new.perform(-1, true)

    flash[:success] = "Job's done." 
    redirect_to '/'
  end

end