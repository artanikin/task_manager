require "rails_helper"

RSpec.describe Task, type: :model do
  it { should belong_to(:user) }
  it { should have_one(:attachment).dependent(:destroy) }

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

  describe "#editable?" do
    let(:assigned_user) { create(:user) }
    let(:admin_user) { create(:user, role: "admin") }
    let(:another_user) { create(:user) }
    let(:task) { create(:task, user: assigned_user) }

    it "should return true for admin user" do
      expect(task.editable?(admin_user)).to be_truthy
    end

    it "should return true for assigned user" do
      expect(task.editable?(assigned_user)).to be_truthy
    end

    it "should return true for not assigned user" do
      expect(task.editable?(another_user)).to be_falsey
    end
  end
end
