class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, length: { minimum: 4 }
  has_many :reviews


  def self.authenticate_with_credentials(email, password)
    sanitized_email = email.gsub(/\s+/, "").downcase

    if @user = User.find_by(email: sanitized_email).try(:authenticate, password)
      @user
    else
      nil
    end
  end



end
