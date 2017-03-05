require "rails_helper"

RSpec.describe ApplicationHelper do
  describe "#name_flash_method" do
    %w(alert error).each do |method|
      it "return '#{method}'" do
        expect(helper.name_flash_method(method)).to eq("danger")
      end
    end

    %w(notice some_one_alse_method).each do |method|
      it "return '#{method}'" do
        expect(helper.name_flash_method(method)).to eq("success")
      end
    end
  end
end
