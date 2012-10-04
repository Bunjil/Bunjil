/
The intersection checking job triggers all need Area Updates to check for and create Intersections.
/
class IntersectionCheckingJob
  def self.perform (area_updates, autoDL=false)
    ActiveRecord::Base.logger.debug 'Running IntersectionCheckingJob'
    area_updates.each do |area_update|
      ActiveRecord::Base.logger.debug "Checking area #{area_update.id}"
      area_update.handle 
    end
    ImageDownloaderJob.new.perform if autoDL
  end
end