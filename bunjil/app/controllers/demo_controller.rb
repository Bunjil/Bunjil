class DemoController < ApplicationController

  def start
    LandsatRssReaderJob.new.perform(-1, true)
  end

end