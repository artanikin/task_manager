class User < ApplicationRecord
  validates :email, :password, presence: true
  validates :email, uniqueness: true
  validates :role, inclusion: { in: %w(admin user) }
  validates :password, confirmation: true
end
