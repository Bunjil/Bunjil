require 'RMagick'
include Magick

class ImageProcessorJob

  def perform
    lRedImage = ImageList.new("brazil1-3.tif")
    lNIRImage = ImageList.new("brazil1-4.tif")
    lNDVIImage = ImageList.new(lRedImage.columns, lRedImage.rows)

    for width in 0..lRedImage.columns
      for height in 0..lRedImage.rows
        lRedPixelRed = lRedImage.pixel_color(width, height).red
        lNIRPixelRed = lNIRImage.pixel_color(width, height).red

        lNDVI = calculate_ndvi(lRedPixel, lNIRPixel)
        lNDVIPixel = color_result(lNDVIPixel)

        lNDVIImage.pixel_color(width, height, lNDVIPixel);

      end
    end

  	lNDVIImage.save
  end

  #Returns the NDVI to Color map result for each pixel's NDVI
  def color_result(double aValue)
    if (aValue <= -0.2d) return Pixel.new(0,0,0,255)
    if (aValue <= -0.1d) return Pixel.new(255, 0, 0, 255)
    if (aValue <= 0) return Pixel.new(201, 0, 0, 255)
    if (aValue <= 0.1d) return Pixel.new(136, 0, 0, 255)
    if (aValue <= 0.2d) return Pixel.new(255, 255, 0, 255)
    if (aValue <= 0.3d) return Pixel.new(185, 185, 0, 255)
    if (aValue <= 0.4d) return Pixel.new(108, 108, 0, 255)
    if (aValue <= 0.5d) return Pixel.new(0, 255, 255, 255)
    if (aValue <= 0.6d) return Pixel.new(0, 128, 192, 255)
    if (aValue <= 0.7d) return Pixel.new(0, 0, 255, 255)
    if (aValue <= 0.8d) return Pixel.new(0, 255, 0, 255)
    if (aValue <= 0.9d) return Pixel.new(0, 255, 64, 255)
    if (aValue <= 1d) return Pixel.new(0, 128, 0, 255)
    return Pixel.new(255, 255, 255, 255)
  end

  def calculate_ndvi(integer aNIR, integer aRed)
    double lNumerator = aNIR - aRed
    if (lNumerator == 0) return 0

    double lDemoninator = aNIR + aRed
    if (lDemoninator == 0) return 0

    return lNumerator / lDemoninator
  end
end