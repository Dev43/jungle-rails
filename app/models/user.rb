class User < ActiveRecord::Base

  has_secure_password

  has_many :reviews

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, length: { minimum: 4 }


  def self.authenticate_with_credentials(email, password)
    sanitized_email = email.gsub(/\s+/, "").downcase

    if @user = User.find_by(email: sanitized_email).try(:authenticate, password)
      @user
    else
      nil
    end
  end



end
