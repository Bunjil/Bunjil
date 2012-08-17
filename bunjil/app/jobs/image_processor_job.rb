require 'RMagick'
include Magick

class ImageProcessorJob 

  def perform
    lRedPath = "/home/megurineluka/BunjilForestWatch/Codebase/bunjil/app/jobs/brazil1-3.tif"
    lNIRPath = "/home/megurineluka/BunjilForestWatch/Codebase/bunjil/app/jobs/brazil1-4.tif"
    lDestination = "/home/megurineluka/BunjilForestWatch/Codebase/bunjil/app/jobs/ndvi.jpg"

    lRedImage = ImageList.new(lRedPath)
    lNIRImage = ImageList.new(lNIRPath)
    lNDVIImage = Image.new(lRedImage.columns, lRedImage.rows)

    for x in 0..lRedImage.columns
      for y in 0..lRedImage.rows
        lRedPixel = lRedImage.pixel_color(x, y).red
        lNIRPixel = lNIRImage.pixel_color(x, y).red

        lNDVI = calculate_ndvi(lRedPixel, lNIRPixel)

        lNDVIPixel = color_result(lNDVI)
        #puts lRedPixel
        #Remove this if ImageMagick configured to 8bit
        lNDVIPixel = Pixel.new(lNDVIPixel.red * 257, lNDVIPixel.green * 257, lNDVIPixel.blue * 257)
        lNDVIImage.pixel_color(x, y, lNDVIPixel)

      end
    end

  	lNDVIImage.write(lDestination)
  end

  #Returns the NDVI to Color map result for each pixel's NDVI
  def color_result(aValue)
    if aValue <= -0.2 
      return Pixel.new(0,0,0,255)
    elsif aValue <= -0.1 
      return Pixel.new(255, 0, 0, 255)
    elsif aValue <= 0 
      return Pixel.new(201, 0, 0, 255)
    elsif aValue <= 0.1 
      return Pixel.new(136, 0, 0, 255)
    elsif aValue <= 0.2 
      return Pixel.new(255, 255, 0, 255)
    elsif aValue <= 0.3 
      return Pixel.new(185, 185, 0, 255)
    elsif aValue <= 0.4 
      return Pixel.new(108, 108, 0, 255)
    elsif aValue <= 0.5 
      return Pixel.new(0, 255, 255, 255)
    elsif aValue <= 0.6 
      return Pixel.new(0, 128, 192, 255)
    elsif aValue <= 0.7 
      return Pixel.new(0, 0, 255, 255)
    elsif aValue <= 0.8 
      return Pixel.new(0, 255, 0, 255)
    elsif aValue <= 0.9 
      return Pixel.new(0, 255, 64, 255)
    elsif aValue <= 1 
      return Pixel.new(0, 128, 0, 255)
    else 
      return Pixel.new(255, 255, 255, 255)
    end
  end

  def calculate_ndvi(aNIR, aRed)
    lNumerator = aNIR - aRed
    if lNumerator == 0
      return 0
    end

    lDemoninator = aNIR + aRed
    if lDemoninator == 0 
      return 0
    end

    return lNumerator.to_f / lDemoninator
  end
end

x = ImageProcessorJob.new()
x.perform
