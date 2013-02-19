module DeviseMacros
  extend ActiveSupport::Concern

  included do
    let(:user) { FactoryGirl.create(:user) }
  end

  def signin_user
    visit new_user_session_path
    fill_in "user_username", with: user.username
    fill_in "user_password", with: user.password
    click_on I18n.t('pages.signin.submit') 
  end
 
  def signup_user(username = "cukubik", password = "nazdrovya", password_confirmation = nil)
    password_confirmation ||= password

    fill_in "user_username", with: username
    fill_in "user_password", with: password
    fill_in "user_password_confirmation", with: password_confirmation
    click_on I18n.t('pages.signup.submit') 
  end
end
