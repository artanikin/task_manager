class Attachment < ApplicationRecord
  belongs_to :task, inverse_of: :attachment

  mount_uploader :file, FileUploader
end
