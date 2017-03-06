require "rails_helper"

RSpec.describe TaskDecorator, type: :decorator do
  let(:task) { create(:task).decorate }

  it "returns datetime for localzone in short format" do
    expect(task.created).to eq(I18n.l(task.created_at.localtime, format: :short))
  end
end
