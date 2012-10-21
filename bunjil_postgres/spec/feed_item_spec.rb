require 'spec_helper'

describe FeedItem, "feed_item" do

  it "initializes correctly".titleize do
    FeedItem.new.is_intersection_checked.should eq(false)
  end
end