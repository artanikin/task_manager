class User < ApplicationRecord
  validates :email, uniqueness: true, email: true
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }
  validates :role, inclusion: { in: %w(admin user) }

  before_create :encrypt_password

  private

  def encrypt_password
    self.password = Digest::SHA1.hexdigest(password)
  end
end
