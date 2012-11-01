require 'spec_helper'

describe IntersectionCheckingJob, "intersection_checking_job" do

  it "loads test database".titleize do
    aus= AreaUpdate.count
    true.should eq(aus>5)
  end
  it "creates intersections after running the job, but doesn't modify AreaUpdates".titleize do
    aus= AreaUpdate.count
    ins= Intersection.count
    IntersectionCheckingJob.new.perform AreaUpdate.all
    true.should eq(Intersection.count>ins)
    true.should eq(AreaUpdate.count==aus)
  end

  it "intersections after running the job have a valid area linked to them, and a valid AreaUpdate linked to them.".titleize do
    IntersectionCheckingJob.new.perform AreaUpdate.all
    Intersection.all.each do |i|
      false.should eq(i.area.nil?)
      false.should eq(i.area_update.nil?)
    end
  end
end