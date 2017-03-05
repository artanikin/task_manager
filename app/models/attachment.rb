class Attachment < ApplicationRecord
  belongs_to :task, inverse_of: :attachment

  mount_uploader :file, FileUploader

  def image?
    file.content_type.start_with?("image")
  end
end
