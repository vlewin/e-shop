class ImageUploader < CarrierWave::Uploader::Base
  if Rails.env.production?
    include Cloudinary::CarrierWave

    process :convert => 'png'
    # process :tags => ['product_image']

    version :standard do
      process :resize_to_fill => [250, 250, :north]
    end

    version :thumbnail do
      resize_to_fit(240, 180)
    end

    def public_id
      return model.name
    end

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    def extension_white_list
      %w(jpg jpeg gif png pdf doc txt)
    end
  else
    storage :file

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    def extension_white_list
      %w(jpg jpeg gif png pdf doc txt)
    end
  end
end

