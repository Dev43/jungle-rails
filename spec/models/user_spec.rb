require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it "should add the user to the database" do
      @new_user = User.create(
        name: "Patrick",
        email: "therookie43@hotmail.com",
        password: '1234',
        password_confirmation: '1234'
        )

       expect(@new_user).to be_valid
    end

    context "Password problem" do
    it "should not add the user to the database because the passwords don't match" do
      @new_user = User.create(
        name: "Patrick",
        email: "therookie43@hotmail.com",
        password: '1234',
        password_confirmation: '12345'
        )

       expect(@new_user).to_not be_valid
    end

    it "should not add the user to the database because no password was given" do
      @new_user = User.create(
        name: "Patrick",
        email: "therookie43@hotmail.com",
        password: nil,
        password_confirmation: nil
        )

       expect(@new_user).to_not be_valid
    end

    it "should not add the user to the database because no password is too short" do
      @new_user = User.create(
        name: "Patrick",
        email: "therookie43@hotmail.com",
        password: '123',
        password_confirmation: '123'
        )

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

      @new_user = User.create(
        name: "Patrick",
        email: "therookie43@hotmail.com",
        password: '1234',
        password_confirmation: '1234'
        )

       expect(@new_user).to_not be_valid
    end

    it "should not add the user to the database because email is not unique and case insensitive" do
      @another_user = User.create(
        name: "Joe Same-Email",
        email: "TEST@TEST.com",
        password: '1234',
        password_confirmation: '1234'
        )

      @new_user = User.create(
        name: "Patrick",
        email: "test@test.COM",
        password: '1234',
        password_confirmation: '1234'
        )

       expect(@new_user).to_not be_valid
    end


    it "should not add the user to the database because email is not given" do
      @new_user = User.create(
        name: "Patrick",
        email: nil,
        password: '1234',
        password_confirmation: '1234'
        )

       expect(@new_user).to_not be_valid
    end
  end

  it "should not add the user to the database because name is not given" do
      @new_user = User.create(
        name: nil,
        email: "therookie43@hotmail.com",
        password: '1234',
        password_confirmation: '1234'
        )

       expect(@new_user).to_not be_valid
    end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "should successfully authenticate a returning user" do
       user = User.create(
        name: "Patrick",
        email: "therookie43@hotmail.com",
        password: '1234',
        password_confirmation: '1234'
        )

       expect(User.authenticate_with_credentials(user.email, user.password)).to be_truthy
    end

    it "should not authenticate due to unrecognized email" do
        user = User.create(
          name: "Patrick",
          email: "therookie43@hotmail.com",
          password: '1234',
          password_confirmation: '1234'
        )

       expect(User.authenticate_with_credentials("NOT_A_VALID_EMAIL@hotmail.com", user.password)).to be_nil
    end

    it "should not authenticate due to wrong password" do
        user = User.create(
          name: "Patrick",
          email: "therookie43@hotmail.com",
          password: '1234',
          password_confirmation: '1234'
        )

       expect(User.authenticate_with_credentials(user.email, "Diff Password")).to be_nil
    end

    it "should authenticate with whitespace at beginning and end of email" do
        user = User.create(
          name: "Patrick",
          email: "therookie43@hotmail.com",
          password: '1234',
          password_confirmation: '1234'
        )

       expect(User.authenticate_with_credentials("  therookie43@hotmail.com  ", user.password)).to be_truthy
    end

    it "should authenticate with case insensitive e-mail" do
        user = User.create(
          name: "Patrick",
          email: "therookie43@hotmail.com",
          password: '1234',
          password_confirmation: '1234'
        )

       expect(User.authenticate_with_credentials("thErookiE43@hotmail.com", user.password)).to be_truthy
    end


  end




  end
end



 # create_table "users", force: :cascade do |t|
 #    t.string   "name"
 #    t.string   "email"
 #    t.string   "password_digest"
 #    t.datetime "created_at",      null: false
 #    t.datetime "updated_at",      null: false
 #  end