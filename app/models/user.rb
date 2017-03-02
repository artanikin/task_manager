class User < ApplicationRecord
  validates :email, uniqueness: true, email: true
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }
  validates :role, inclusion: { in: %w(admin user) }

  before_create :set_encrypt_password

  def authenticate(pass)
    password == encrypt(pass) ? self : false
  end

  private

  def set_encrypt_password
    self.password = encrypt(password)
  end

  def encrypt(password)
    Digest::SHA1.hexdigest(password + Rails.application.secrets.salt)
  end
end
