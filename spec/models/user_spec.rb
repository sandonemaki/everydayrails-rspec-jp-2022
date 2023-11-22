require 'rails_helper'

RSpec.describe User, type: :model do
  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  #it "is valid with a first name, last name and email, and password" do
  #  user = User.new(
  #    first_name: "Aaron",
  #    last_name:  "Sumner",
  #    email:      "tester@example.com",
  #    password:   "dottle-nouveau-pavilion-tights-furze",
  #  )
  #  expect(user).to be_valid
  #end

  it "is invalid without a first name" do
    #user = User.new(first_name: nil)
    user = FactoryBot.build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without a last name" do
    #user = User.new(last_name: nil)
    user = FactoryBot.build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without an email address" do
    #user = User.new(email: nil)
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    #User.create(
    #  first_name:  "Joe",
    #  last_name:  "Tester",
    #  email:      "tester@example.com",
    #  password:   "dottle-nouveau-pavilion-tights-furze",
    #)
    FactoryBot.create(:user, email: "aaron@example.com")
    #user = User.new(
    #  first_name:  "Jane",
    #  last_name:  "Tester",
    #  email:      "tester@example.com",
    #  password:   "dottle-nouveau-pavilion-tights-furze",
    #)
    user = FactoryBot.build(:user, email: "aaron@example.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "returns a user's full name as a string" do
    #user = User.new(
    #  first_name: "John",
    #  last_name:  "Doe",
    #  email:      "johndoe@example.com",
    #)
    FactoryBot.build(:user, first_name: "John", last_name: "Doe")
    expect(user.name).to eq "John Doe"
  end
end
