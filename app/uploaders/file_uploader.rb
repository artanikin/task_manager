class FileUploader < CarrierWave::Uploader::Base
  delegate :identifier, to: :file

  permissions 0777
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
