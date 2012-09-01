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
        lNDVIPixel = Pixel.new(lNDVIPixel.red * 256, lNDVIPixel.green * 256, lNDVIPixel.blue * 256)
        lNDVIImage.pixel_color(x, y, lNDVIPixel)

      end
    end

  	lNDVIImage.write(lDestination)
  end

  #Returns the NDVI to Color map result for each pixel's NDVI
  def color_result(aValue)
    if    aValue <=-1.000 
      return Pixel.new(  5,  24,  82, 255)
    elsif aValue <=-0.300 
      return Pixel.new(  5,  24,  82, 255)
    elsif aValue <=-0.180 
      return Pixel.new(255, 255, 255, 255)
    elsif aValue <= 0.000 
      return Pixel.new(255, 255, 255, 255)
    elsif aValue <= 0.025 
      return Pixel.new(206, 197, 180, 255)
    elsif aValue <= 0.075 
      return Pixel.new(191, 163, 124, 255)
    elsif aValue <= 0.125 
      return Pixel.new(179, 174,  96, 255)
    elsif aValue <= 0.150 
      return Pixel.new(163, 181,  80, 255)
    elsif aValue <= 0.175 
      return Pixel.new(144, 170,  60, 255)
    elsif aValue <= 0.233 
      return Pixel.new(166, 195,  29, 255)
    elsif aValue <= 0.266 
      return Pixel.new(135, 183,   3, 255)
    elsif aValue <= 0.333 
      return Pixel.new(121, 175,   1, 255)
    elsif aValue <= 0.366 
      return Pixel.new(101, 163,   0, 255)
    elsif aValue <= 0.433 
      return Pixel.new( 78, 151,   0, 255)
    elsif aValue <= 0.466 
      return Pixel.new( 43, 132,   4, 255)
    elsif aValue <= 0.550 
      return Pixel.new(  0, 114,   0, 255)
    elsif aValue <= 0.650 
      return Pixel.new(  0,  90,   1, 255)
    elsif aValue <= 0.750 
      return Pixel.new(  0,  73,   0, 255)
    elsif aValue <= 0.850 
      return Pixel.new(  0,  56,   0, 255)
    elsif aValue <= 0.950 
      return Pixel.new(  0,  31,   0, 255)
    elsif aValue <= 1.000 
      return Pixel.new(  0,   0,   0, 255)
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
