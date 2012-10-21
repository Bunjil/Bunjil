require 'test_helper'

class ImageProcessorTest < ActiveSupport::TestCase
	test "image processor success" do
 	   lRedPath = "/home/megurineluka/BunjilForestWatch/Codebase/bunjil/app/jobs/brazil1-3.tif"
	    lNIRPath = "/home/megurineluka/BunjilForestWatch/Codebase/bunjil/app/jobs/brazil1-4.tif"
		x = ImageProcessorJob.new()
		assert x.perform(0, lRedPath, lNIRPath)
	end
end
