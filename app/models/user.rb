require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  EMAIL_REGEX = /\A[a-z\d_+.\-]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  USER_REGEX = /\A\w+\z/
  COLOR_REGEX = /\A#[\da-z]{,6}\z/i

  attr_accessor :password

  has_many :questions

  validates :email, :username, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, on: :create
  validates :username, length: { maximum: 40 }, format: { with:  USER_REGEX }
  validates :email, format: { with:  EMAIL_REGEX }

  before_validation :downcase_username, :downcase_email
  before_save :encrypt_password
  before_save :check_background_color

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end


  def self.authenticate(email, password)
    user = find_by(email: email&.downcase)

    return nil unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    return user if user.password_hash == hashed_password

    nil
  end

  private

  def check_background_color
    unless background_color.nil? || background_color.match?(COLOR_REGEX)
      background_color = '#005a55'
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )
    end
  end

  def downcase_username
    username&.downcase!
  end
  
  def downcase_email
    email&.downcase!
  end
end
