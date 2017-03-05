FactoryGirl.define do
  factory :attachment do
    file { Rack::Test::UploadedFile.new(File.open("#{Rails.root}/spec/files/ruby.jpeg")) }
    task
  end
end
