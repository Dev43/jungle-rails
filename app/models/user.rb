class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, length: { minimum: 4 }
  has_many :reviews


  def self.authenticate_with_credentials(email, password)
    @user = User.find_by(email: email).try(:authenticate, password)
    if(@user)
      @user
    else
      nil
    end
  end



end
