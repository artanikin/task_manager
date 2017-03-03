class Task < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :state, inclusion: { in: %w(new started finished) }

  def assigned?(human)
    user == human
  end
end
