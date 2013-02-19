require 'spec_helper'

describe "Signing-up" do
  before do
    # enter through root
    visit root_path
    click_link I18n.t('pages.landing.call_to_action.start')
  end

  describe "by nonuser" do
    it "redirects to contact page when successful" do
      visit root_path
      click_link I18n.t('pages.landing.call_to_action.start')

      # verify we are on signup page
      current_path.should eq(new_user_registration_path)

      signup_user

      # check if redirected_to contacts page
      current_path.should eq(contacts_path)

    end

    before { visit new_user_registration_path  }
    it "doesnt suck on i18n" do
      page.body.should_not match(/translation missing/)
    end

    it "contains landing navigation" do
      page.should have_xpath('//nav')

      within('nav') do
        page.should have_content(I18n.t('pages.sign_in_text'))
        page.should have_link(I18n.t('pages.sign_in_button'))
      end
    end

    it "has proper title" do
      page_have_title(I18n.t('pages.signup.title')) 
    end

    it "loads correct assets" do
      page_have_script('landing') 
      page_have_style('landing') 
      page_have_not_script('application')
      page_have_not_style('application')
    end

    describe "entering uncorrect info gives proper response" do
      it "#username" do
        signup_user("^ciplak_kral^", "asdasd123")
        
        current_path.should eq(user_registration_path)
        page.should have_content(I18n.t('pages.signup.flash.error'))
        page.should have_selector('.alert')
      end

      it "#unmatched_password" do
        signup_user("samet", "seksipass", "cirkinpass")
        current_path.should eq(user_registration_path)

        page.should have_content(I18n.t('pages.signup.flash.error'))
        page.should have_selector('.alert')
      end
    end
  end

  describe "by signedin user" do
    before { signin_user }
    it "directly redirects_to contact page" do
      current_path.should eq(contacts_path)
    end
  end
end
