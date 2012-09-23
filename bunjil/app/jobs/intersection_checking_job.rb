/ Runs all intersection checks.
*/
class IntersectionCheckingJob
  def self.perform area_updates
    ActiveRecord::Base.logger.debug 'Running IntersectionCheckingJob'
    area_updates.each do |area_update|
      ActiveRecord::Base.logger.debug "Checking area #{area_update.id}"
      area_update.handle 
    end
  end
end