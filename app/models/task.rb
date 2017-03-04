class Task < ApplicationRecord
  belongs_to :user
  has_one :attachment

  validates :name, presence: true
  validates :state, inclusion: { in: %w(new started finished) }

  accepts_nested_attributes_for :attachment

  def assigned?(human)
    user == human
  end

  def editable?(human)
    user == human || human.admin?
  end
end
