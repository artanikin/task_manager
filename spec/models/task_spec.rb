require "rails_helper"

RSpec.describe Task, type: :model do
  it { should belong_to(:user) }

  it { should validate_presence_of(:name) }
  it { should validate_inclusion_of(:state).in_array(%w(new started finished)) }
end
