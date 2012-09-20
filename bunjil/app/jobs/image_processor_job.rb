require 'RMagick'
include Magick

class ImageProcessorJob

  #Takes a red image and near infrared image and performs NDVI Calculation
  def perform(area_update, red_path, nir_path)
    destination = red_path +  '_ndvi.tif'

    red_image = ImageList.new(red_path)
    nir_image = ImageList.new(nir_path)
    ndvi_image = Image.new(red_image.columns, red_image.rows)

    for x in 0..red_image.columns
      for y in 0..red_image.rows
        red_pixel = red_image.pixel_color(x, y).red
        nir_pixel = nir_image.pixel_color(x, y).red

        ndvi = calculate_ndvi(red_pixel, nir_pixel)

        ndvi_pixel = color_result(ndvi)
        ndvi_image.pixel_color(x, y, ndvi_pixel)
      end
    end

  	ndvi_image.write(destination)
    File.delete(red_path)
    File.delete(nir_path)
    area_update.image_archive_url = destination
  end

  #Returns the NDVI to Color map result for each pixel's NDVI
  def color_result(pixel_value)
    return Pixel.new(  5,  24,  82) if pixel_value <=-1.000
    return Pixel.new(  5,  24,  82) if pixel_value <=-0.300 
    return Pixel.new(255, 255, 255) if pixel_value <=-0.180 
    return Pixel.new(255, 255, 255) if pixel_value <= 0.000
    return Pixel.new(206, 197, 180) if pixel_value <= 0.025
    return Pixel.new(191, 163, 124) if pixel_value <= 0.075
    return Pixel.new(179, 174,  96) if pixel_value <= 0.125
    return Pixel.new(163, 181,  80) if pixel_value <= 0.150
    return Pixel.new(144, 170,  60) if pixel_value <= 0.175
    return Pixel.new(166, 195,  29) if pixel_value <= 0.233
    return Pixel.new(135, 183,   3) if pixel_value <= 0.266
    return Pixel.new(121, 175,   1) if pixel_value <= 0.333
    return Pixel.new(101, 163,   0) if pixel_value <= 0.366
    return Pixel.new( 78, 151,   0) if pixel_value <= 0.433
    return Pixel.new( 43, 132,   4) if pixel_value <= 0.466
    return Pixel.new(  0, 114,   0) if pixel_value <= 0.550
    return Pixel.new(  0,  90,   1) if pixel_value <= 0.650
    return Pixel.new(  0,  73,   0) if pixel_value <= 0.750
    return Pixel.new(  0,  56,   0) if pixel_value <= 0.850
    return Pixel.new(  0,  31,   0) if pixel_value <= 0.950
    return Pixel.new(  0,   0,   0) if pixel_value <= 1.000
    return Pixel.new(255, 255, 255)
  end

  def calculate_ndvi(nir, red)
    numerator = nir - red
    return 0 if numerator == 0

    demoninator = nir + red
    return 0 if demoninator == 0 

    return numerator.to_f / demoninator
  end
end