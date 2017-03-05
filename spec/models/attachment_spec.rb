require "rails_helper"

RSpec.describe Attachment, type: :model do
  it { should belong_to(:task) }

  describe "#image?" do
    it "return true if file is image" do
      attachment = create(:attachment)
      expect(attachment.image?).to be_truthy
    end

    it "return false if file is not image" do
      path = "#{Rails.root}/spec/files/simple.txt"
      attachment = create(:attachment, file: Rack::Test::UploadedFile.new(File.open(path)))
      expect(attachment.image?).to be_falsey
    end
  end
end
