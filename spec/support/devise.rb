module DeviseMacros
  extend ActiveSupport::Concern


  included do
    let(:user) { FactoryGirl.create(:user) }
  end


  def signin_user(opts = {})
    opts = opts.reverse_merge( username: user.username, 
                               password: user.password, 
                               motive:   :capybara      ) 

    send("signin_user_for_#{opts[:motive]}", opts)

    user
  end


  def signin_user_for_rack_test(opts)
    post user_session_path, user: { username: opts[:username], 
                                    password: opts[:password]  } 
  end


  def signin_user_for_capybara(opts)
    visit new_user_session_path
    fill_in "user_username", with: opts[:username]
    fill_in "user_password", with: opts[:password]
    click_on I18n.t('pages.signin.submit') 
  end
 

  def signup_user(username = "cukubik", password = "nazdrovya", password_confirmation = nil)
    password_confirmation ||= password

    fill_in "user_username", with: username
    fill_in "user_password", with: password
    fill_in "user_password_confirmation", with: password_confirmation
    click_on I18n.t('pages.signup.submit') 
  end


  def signout_user
    click_on I18n.t('pages.sign_out_button')
  end
end
