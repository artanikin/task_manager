class Task < ApplicationRecord
  belongs_to :user
  has_one :attachment, inverse_of: :task, dependent: :destroy

  validates :name, presence: true
  validates :state, inclusion: { in: %w(new started finished) }

  accepts_nested_attributes_for :attachment, allow_destroy: true

  state_machine initial: :new do
    event :start do
      transition new: :started
    end

    event :finish do
      transition started: :finished
    end
  end

  def self.for_user(human)
    (human.admin? ? all.include(:user) : human.tasks).order("created_at DESC")
  end

  def assigned?(human)
    user == human
  end

  def editable?(human)
    user == human || human.admin?
  end

  def change_state(human, event)
    if editable?(human) && state_events.include?(event.to_sym) && send("can_#{event}?")
      send(event)
    else
      false
    end
  end
end
