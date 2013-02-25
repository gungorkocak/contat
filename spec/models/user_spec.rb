require 'spec_helper'

describe User do

  it { should have_many(:contacts).dependent(:destroy) }

  context "#username" do
    subject { FactoryGirl.build(:user, password: "naberullah", password_confirmation: "naberullah") }

    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should_not allow_value("sdf$^%&*()!$").for(:username) }
    it { should allow_value("ahmet").for(:username) }
    it { should ensure_length_of(:username).is_at_least(3).is_at_most(50) }
  end

  context "#password" do
    subject { FactoryGirl.build(:user, username: "ahmet") }
    it { should ensure_length_of(:password).is_at_least(8) }

    it " password and confirmation matches" do
      user = FactoryGirl.build(:user, password: "ahmet", password_confirmation: "naber")
      user.should_not be_valid
    end
  end

end
