# == Schema Information
#
# Table name: feeds
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#LandsatRssReaderJob.new.perform


require 'test_helper'
require 'feedzirra'

class FeedTest < ActiveSupport::TestCase
  test "format img url" do
     url='<![CDATA[<font face="arial" size="2">
<a href="http://earthexplorer.usgs.gov/browse/etm/138/45/2012/LE71380452012195EDC00.jpg">
<img src="http://earthexplorer.usgs.gov/ajax/getthumb/?ds=LANDSAT_ETM_SLC_OFF&tp=138/45/2012/LE71380452012195EDC00.jpg&eid=LE71380452012195EDC00&cid=3373" align="left" hspace="8" alt="Click for larger view"></a>
Image from the <a href="http://landsat.usgs.gov/about_landsat7.php">
Landsat 7 satellite</a><br/>
Path 138, Row 45, Cloud cover   44.47%<br/>
Scene ID: LE71380452012195EDC00
</font>]]>'
    feed=LandsatRssReaderJob.new
    s=feed.format_image_url url
    puts s
    assert_equal s, "http://earthexplorer.usgs.gov/browse/etm/138/45/2012/LE71380452012195EDC00.jpg"
  end 

  test "feed" do
     feed=LandsatRssReaderJob.new
     
     assert feed.perform
  end

   
end
