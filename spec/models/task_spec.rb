require "rails_helper"

RSpec.describe Task, type: :model do
  it { should belong_to(:user) }

  it { should validate_presence_of(:name) }
  it { should validate_inclusion_of(:state).in_array(%w(new started finished)) }

  describe "#assigned?" do
    let!(:user) { create(:user) }
    let!(:task) { create(:task) }

    it "should not task assigned to user" do
      expect(task.assigned?(user)).to be_falsey
    end

    it "should task assigned to user" do
      task.user = user
      expect(task.assigned?(user)).to be_truthy
    end
  end
end
