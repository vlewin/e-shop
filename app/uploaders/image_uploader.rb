class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  include CarrierWave::RMagick

  process :tags => ['product_image']
  process :convert => 'png'

  version :standard do
    process :resize_to_fill => [250, 250]
  end

  version :thumbnail, :from_version => :standard do
    process :resize_to_fill => [240,120]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    Rails.root.join('tmp/cache')
  end

  def public_id
    return model.name
  end
end

