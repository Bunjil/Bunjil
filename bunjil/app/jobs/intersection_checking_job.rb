=begin
The intersection checking job triggers all need Area Updates to check for and create Intersections.
This class does not use static methods for concurrency purposes.
=end
class IntersectionCheckingJob
  def call (autoDL=false)
    area_updates = AreaUpdate.where(has_been_intersection_checked: false)
    perform area_updates, autoDL
  end
  def perform (area_updates, autoDL=false)
    ActiveRecord::Base.logger.debug 'Running IntersectionCheckingJob'
    ActiveRecord::Base.logger.debug 'Will call image downloader when done!' if autoDL
    area_updates.each do |area_update|
      if (area_update.has_been_intersection_checked == false)
            # ensure it's still false.
        ActiveRecord::Base.logger.debug "Checking area #{area_update.id}"
        area_update.handle 
      end
    end
    ImageDownloaderJob.new.perform if autoDL
  end
end