require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    before(:each) do
      @new_user = User.new(
        name: "Patrick",
        email: "therookie43@hotmail.com",
        password: '1234',
        password_confirmation: '1234'
        )
    end

    it "should add the user to the database" do
      @new_user.save
      expect(@new_user).to be_valid
    end

    context "Password problem" do
    it "should not add the user to the database because the passwords don't match" do
      @new_user.password_confirmation = '12345'
      @new_user.save
      expect(@new_user).to_not be_valid
    end

    it "should not add the user to the database because no password was given" do
      @new_user.password = nil
      @new_user.save
      expect(@new_user).to_not be_valid
    end

    it "should not add the user to the database because no password is too short" do
      @new_user.password = '123'
      @new_user.password_confirmation = '123'
      @new_user.save
      expect(@new_user).to_not be_valid
    end
  end

  context "Email problems" do

    it "should not add the user to the database because email is not unique" do
      @another_user = User.create(
        name: "Joe Same-Email",
        email: "therookie43@hotmail.com",
        password: '1234',
        password_confirmation: '1234'
      )
      @new_user.save

      expect(@new_user).to_not be_valid
    end

    it "should not add the user to the database because email is not unique and case insensitive" do
      @another_user = User.create(
        name: "Joe Same-Email",
        email: "TEST@TEST.com",
        password: '1234',
        password_confirmation: '1234'
      )

      @new_user.email = "test@test.COM"
      @new_user.save
      expect(@new_user).to_not be_valid
    end


    it "should not add the user to the database because email is not given" do
      @new_user.email = nil
      @new_user.save
      expect(@new_user).to_not be_valid
    end
  end

  it "should not add the user to the database because name is not given" do
      @new_user.name = nil
      @new_user.save
      expect(@new_user).to_not be_valid
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "should successfully authenticate a returning user" do
      @new_user.save

       expect(User.authenticate_with_credentials(@new_user.email, @new_user.password)).to be_truthy
    end

    it "should not authenticate due to unrecognized email" do
      @new_user.save
      expect(User.authenticate_with_credentials("NOT_A_VALID_EMAIL@hotmail.com", @new_user.password)).to be_nil
    end

    it "should not authenticate due to wrong password" do
      @new_user.save
      expect(User.authenticate_with_credentials(@new_user.email, "Diff Password")).to be_nil
    end

    it "should authenticate with whitespace at beginning and end of email" do
      @new_user.save
      expect(User.authenticate_with_credentials("  therookie43@hotmail.com  ", @new_user.password)).to be_truthy
    end

    it "should authenticate with case insensitive e-mail" do
      @new_user.save
      expect(User.authenticate_with_credentials("thErookiE43@hotmail.com", @new_user.password)).to be_truthy
    end
  end

  end
end

