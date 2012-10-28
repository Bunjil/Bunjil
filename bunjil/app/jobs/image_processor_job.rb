=begin
  * Name: Image Processor Job
  * Description: 
          * Called by the Image Downloader Job
          * Requires the Band 3 and Band 4 Images
          * Performs the NDVI Processing
          * Saves new NDVI Image
          * Deletes Band 3 and Band 4 Images
  * Author: David de Souza
=end
require 'RMagick'
include Magick

class ImageProcessorJob

  #Takes a red image and near infrared image and performs NDVI Calculation
  def perform(area_update, red_path, nir_path)
    destination = red_path +  '_ndvi.jpg'

    red_image = ImageList.new(red_path)
    nir_image = ImageList.new(nir_path)
    ndvi_image = Image.new(red_image.columns, red_image.rows)

    for x in 0..red_image.columns
      for y in 0..red_image.rows
        red_pixel = red_image.pixel_color(x, y).red
        nir_pixel = nir_image.pixel_color(x, y).red

        ndvi = calculate_ndvi(nir_pixel, red_pixel)

        ndvi_pixel = color_result(ndvi)
        ndvi_image.pixel_color(x, y, ndvi_pixel)
      end
      if (((x + 1) * y) % 500) == 0
        processed = ((x + 1) * y)
        total = red_image.columns * red_image.rows
        puts processed.to_s + ' / ' + total.to_s + ' pixels processed....(' + ((processed.to_f/total.to_f)*100).round(0).to_s + '%)'
      end
    end

  	ndvi_image.write(destination)
    #File.delete(red_path)
    #File.delete(nir_path)
    area_update.image_url = destination
    area_update.save
  end
 

  def perform()
    task = ImageProcessorTask.find(:first)
    return if task.nil?
    ImageProcessorTask.delete(task)

    red_image = ImageList.new(task.red)
    nir_image = ImageList.new(task.near_infrared)
    ndvi_image = Image.new(red_image.columns, red_image.rows)
    area_update = task.area_update

    destination = task.red +  '_ndvi.jpg'

    for x in 0..red_image.columns
      for y in 0..red_image.rows
        red_pixel = red_image.pixel_color(x, y).red
        nir_pixel = nir_image.pixel_color(x, y).red

        ndvi = calculate_ndvi(nir_pixel, red_pixel)

        ndvi_pixel = color_result(ndvi)
        ndvi_image.pixel_color(x, y, ndvi_pixel)
      end
      if (((x + 1) * y) % 500) == 0
        processed = ((x + 1) * y)
        total = red_image.columns * red_image.rows
        puts processed.to_s + ' / ' + total.to_s + ' pixels processed....(' + ((processed.to_f/total.to_f)*100).round(0).to_s + '%)'
      end
    end

    ndvi_image.write(destination)
    #File.delete(red_path)
    #File.delete(nir_path)
    area_update.image_url = destination
    area_update.save
  end

  #Returns the NDVI to Color map result for each pixel's NDVI
  def color_result(pixel_value)
    return Pixel.new(  5 * 256,  24 * 256,  82 * 256) if pixel_value <=-1.000
    return Pixel.new(  5 * 256,  24 * 256,  82 * 256) if pixel_value <=-0.300 
    return Pixel.new(255 * 256, 255 * 256, 255 * 256) if pixel_value <=-0.180 
    return Pixel.new(255 * 256, 255 * 256, 255 * 256) if pixel_value <= 0.000
    return Pixel.new(206 * 256, 197 * 256, 180 * 256) if pixel_value <= 0.025
    return Pixel.new(191 * 256, 163 * 256, 124 * 256) if pixel_value <= 0.075
    return Pixel.new(179 * 256, 174 * 256,  96 * 256) if pixel_value <= 0.125
    return Pixel.new(163 * 256, 181 * 256,  80 * 256) if pixel_value <= 0.150
    return Pixel.new(144 * 256, 170 * 256,  60 * 256) if pixel_value <= 0.175
    return Pixel.new(166 * 256, 195 * 256,  29 * 256) if pixel_value <= 0.233
    return Pixel.new(135 * 256, 183 * 256,   3 * 256) if pixel_value <= 0.266
    return Pixel.new(121 * 256, 175 * 256,   1 * 256) if pixel_value <= 0.333
    return Pixel.new(101 * 256, 163 * 256,   0 * 256) if pixel_value <= 0.366
    return Pixel.new( 78 * 256, 151 * 256,   0 * 256) if pixel_value <= 0.433
    return Pixel.new( 43 * 256, 132 * 256,   4 * 256) if pixel_value <= 0.466
    return Pixel.new(  0 * 256, 114 * 256,   0 * 256) if pixel_value <= 0.550
    return Pixel.new(  0 * 256,  90 * 256,   1 * 256) if pixel_value <= 0.650
    return Pixel.new(  0 * 256,  73 * 256,   0 * 256) if pixel_value <= 0.750
    return Pixel.new(  0 * 256,  56 * 256,   0 * 256) if pixel_value <= 0.850
    return Pixel.new(  0 * 256,  31 * 256,   0 * 256) if pixel_value <= 0.950
    return Pixel.new(  0 * 256,   0 * 256,   0 * 256) if pixel_value <= 1.000
    return Pixel.new(  0 * 256,   0 * 256,   0 * 256)
  end

  def calculate_ndvi(nir, red)
    numerator = nir - red
    return 0 if numerator == 0

    demoninator = nir + red
    return 0 if demoninator == 0 

    result = numerator.to_f / demoninator.to_f
    return result
  end
end
