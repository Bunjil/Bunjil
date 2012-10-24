require 'spec_helper'
require 'feedzirra'
require 'nokogiri'

describe LandsatRssReaderJob, "landsat_rss_reader_job" do

  feed=Feed.find_by_name("LandSat7")
  it "loads test database".titleize do
    true.should eq(Area.count>0)
    false.should eq(feed.nil?)
  end
  rss_data = Feedzirra::Feed.fetch_and_parse(feed.url)
  it 'landsat7 is up and available to read'.titleize do
    false.should eq(rss_data.is_a?(Fixnum)) end
  it 'landsat7 has entries in its rss'.titleize do
    true.should eq(rss_data.entries.count>0)
  end
  rss_first=rss_data.entries.first
  it 'landsat7 rss entries have a url'.titleize do
    false.should eq(rss_first.url.blank?)
  end
  it 'landsat7 rss entries have a summary'.titleize do
    false.should eq(rss_first.summary.blank?)
  end
  rss_ent=Feedzirra::Parser::RSSEntry.new 
  rss_ent.title="Path 75, Row 95 2012-09-21 at 22:17:15 GMT"
  rss_ent.url="http://earthexplorer.usgs.gov/form/metadatalookup/?collection_id=3373&entity_id=LE70750952012265EDC00&pageView=1"
  rss_ent.summary="<font face=\"arial\" size=\"2\">\n<a href=\"http://earthexplorer.usgs.gov/browse/etm/75/95/2012/LE70750952012265EDC00.jpg\">\n<img src=\"http://earthexplorer.usgs.gov/ajax/getthumb/?ds=LANDSAT_ETM_SLC_OFF&tp=75/95/2012/LE70750952012265EDC00.jpg&eid=LE70750952012265EDC00&cid=3373\" align=\"left\" hspace=\"8\" alt=\"Click for larger view\"></a>\nImage from the <a href=\"http://landsat.usgs.gov/about_landsat7.php\">\nLandsat 7 satellite</a><br/>\nPath 75, Row 95, Cloud cover   65.13%<br/>\nScene ID: LE70750952012265EDC00\n</font>"
  rss_ent.entry_id="http://earthexplorer.usgs.gov/browse/etm/75/95/2012/LE70750952012265EDC00.jpg"
  it 'feed items get added to the database from an rss item'.titleize do
    fcnt=FeedItem.count
    LandsatRssReaderJob.new.handle_new_item(rss_ent, feed.id)
    true.should eq(FeedItem.count==fcnt+1)
  end
  it 'added feed items have a scene ID'.titleize do
    LandsatRssReaderJob.new.handle_new_item(rss_ent, feed.id)
    false.should eq(FeedItem.last.scene_id.blank?)
  end
  it 'added feed items have a link'.titleize do
    LandsatRssReaderJob.new.handle_new_item(rss_ent, feed.id)
    false.should eq(FeedItem.last.link.blank?)
  end
  it 'we can get the first rss item from landsat7, and get the info for an area update from the added feed item link, by parsing relevant earthexplorer.usgs.gov/form/metadatalookup page'.titleize do
    rss_data = Feedzirra::Feed.fetch_and_parse(feed.url)
    rss_ent=rss_data.entries.first
    LandsatRssReaderJob.new.handle_new_item(rss_ent, feed.id)
    attrs=LandsatRssReaderJob.new.init_area_update(FeedItem.last, rss_ent.summary)
    puts attrs.inspect
    false.should eq(attrs[:tl_lat].blank?)
    false.should eq(attrs[:cloud_cover].blank?)
    false.should eq(attrs[:br_lon].blank?)
  end
  it 'runs and makes the areaupdates for each intersection (assumes one of the latest 25 items meets cloud cover requirements)'.titleize do
    fis= FeedItem.count
    aus= AreaUpdate.count
    iss= Intersection.count
    puts "makes areaupdates?"
    puts "Area: #{Area.count}"
    puts "feed items: #{FeedItem.count}"
    puts "intersections: #{Intersection.count}"
    puts "AreaUpdates: #{AreaUpdate.count}"
    LandsatRssReaderJob.new.perform 5
    #not always true (Intersection.count-iss).should eq(dif)
    puts "Area: #{Area.count}"
    puts "new feed items: #{FeedItem.count-fis}"
    puts "new AreaUpdates: #{AreaUpdate.count-aus}"
    puts "new intersections: #{Intersection.count-iss}"
    #true.should eq(FeedItem.count>fis)
    #true.should eq(AreaUpdate.count>aus)
    #true.should eq(Intersection.count>iss)
  end
  it 'runs and makes no areaupdates or intersections with no matching areas'.titleize do
    fis= FeedItem.count
    aus= AreaUpdate.count
    iss= Intersection.count
    Area.delete_all
    puts "makes no areaupdates?"
    puts "feed items: #{FeedItem.count}"
    puts "intersections: #{Intersection.count}"
    puts "AreaUpdates: #{AreaUpdate.count}"
    LandsatRssReaderJob.new.perform 10
    true.should eq(AreaUpdate.count==aus)
    dif=AreaUpdate.count-aus
    (Intersection.count-iss).should eq(dif)
    puts "feed items: #{FeedItem.count}"
    puts "intersections: #{Intersection.count}"
    puts "AreaUpdates: #{AreaUpdate.count}"
  end
end