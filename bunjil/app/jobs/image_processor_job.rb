require 'RMagick'
include Magick

class ImageProcessorJob

  def perform(aAreaUpdate, aRedPath, aNIRPath)
    lDestination = "ndvi.jpg"

    puts "Loading Red Image"
    lRedImage = ImageList.new(aRedPath)
    puts "Red Image Loaded"
    puts "Loading NIR Image"
    lNIRImage = ImageList.new(aNIRPath)
    puts "NIR Image "
    lNDVIImage = Image.new(lRedImage.columns, lRedImage.rows)
    puts "NIR Image Loaded"

    puts "Columns: " + lRedImage.columns.to_s
    puts "Rows: " + lRedImage.rows.to_s
    puts "Commencing NDVI"
    puts Time.now
    val = 0

    for x in 0..lRedImage.columns
      for y in 0..lRedImage.rows
        lRedPixel = lRedImage.pixel_color(x, y).red
        lNIRPixel = lNIRImage.pixel_color(x, y).red

        lNDVI = calculate_ndvi(lRedPixel, lNIRPixel)

        lNDVIPixel = color_result(lNDVI)
        lNDVIImage.pixel_color(x, y, lNDVIPixel)
      end
      if x == (val + 200)
        puts "Columns so far: " + x.to_s
        puts "Time: " + Time.now.to_s
        val = val + 200
      end

    end

  	lNDVIImage.write(lDestination)
    puts "NDVI Complete!"
    puts Time.now
    #TODO: Save Image
    #TODO: Delete Red NIR
    #TODO: Set New Image Path to Item
    #TODO: Notify Area Update that it is complete
  end

  #Returns the NDVI to Color map result for each pixel's NDVI
  def color_result(aValue)
     
    if aValue <=-1.000
      return Pixel.new(  5,  24,  82) 
    elsif aValue <=-0.300 
      return Pixel.new(  5,  24,  82)
    elsif aValue <=-0.180 
      return Pixel.new(255, 255, 255)
    elsif aValue <= 0.000 
      return Pixel.new(255, 255, 255)
    elsif aValue <= 0.025 
      return Pixel.new(206, 197, 180)
    elsif aValue <= 0.075 
      return Pixel.new(191, 163, 124)
    elsif aValue <= 0.125 
      return Pixel.new(179, 174,  96)
    elsif aValue <= 0.150 
      return Pixel.new(163, 181,  80)
    elsif aValue <= 0.175 
      return Pixel.new(144, 170,  60)
    elsif aValue <= 0.233 
      return Pixel.new(166, 195,  29)
    elsif aValue <= 0.266 
      return Pixel.new(135, 183,   3)
    elsif aValue <= 0.333 
      return Pixel.new(121, 175,   1)
    elsif aValue <= 0.366 
      return Pixel.new(101, 163,   0)
    elsif aValue <= 0.433 
      return Pixel.new( 78, 151,   0)
    elsif aValue <= 0.466 
      return Pixel.new( 43, 132,   4)
    elsif aValue <= 0.550 
      return Pixel.new(  0, 114,   0)
    elsif aValue <= 0.650 
      return Pixel.new(  0,  90,   1)
    elsif aValue <= 0.750 
      return Pixel.new(  0,  73,   0)
    elsif aValue <= 0.850 
      return Pixel.new(  0,  56,   0)
    elsif aValue <= 0.950 
      return Pixel.new(  0,  31,   0)
    elsif aValue <= 1.000 
      return Pixel.new(  0,   0,   0)
    else                  
      return Pixel.new(255, 255, 255) 
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

#B3 = "/home/megurineluka/BunjilForestWatch/Codebase/bunjil/app/jobs/B3.TIF"
#B4 = "/home/megurineluka/BunjilForestWatch/Codebase/bunjil/app/jobs/B4.TIF"
#x = ImageProcessorJob.new()
#x.perform(0, B3, B4)
#puts "done"