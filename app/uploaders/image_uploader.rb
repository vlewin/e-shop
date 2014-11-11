class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  include CarrierWave::RMagick

  process tags: ['product_image']
  process convert: 'png'

  version :show do
    process eager: true
    process resize_to_fill: [380, 380]
  end

  version :index, from_version: :show do
    process eager: true
    process resize_to_fill: [250, 200]
  end

  version :thumbnail, from_version: :show do
    process eager: true
    process resize_to_fill: [50,50]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def public_id
    model.title.gsub(' ', '_').gsub('.', '').gsub('%', '')
  end
end

