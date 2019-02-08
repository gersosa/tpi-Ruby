class User < ApplicationRecord
	validates_presence_of :username, :screen_name, :email, :password_digest
	validates :email, :username, uniqueness: true
	has_secure_password
	has_secure_token
	has_many :questions, dependent: :destroy
  	has_many :answers, dependent: :delete_all

  def self.valid_login?(email, password)
    user = find_by(email: email)
    if user && user.authenticate(password)
      user
    end
  end

  def regenerate_token
    touch(:token_created_at)
  end

  def logout
    invalidate_token
  end

  def self.with_unexpired_token(token, period)
    where(token: token).where('token_created_at >= ?', period).first
  end

  private

  # This method is not available in has_secure_token
  def invalidate_token
    update_columns(token: nil)
    touch(:token_created_at)
  end
end
