require 'spec_helper'

describe "VisitingContacts", integration: true do
  context "without signing in" do
    before { visit contacts_path }

    it "redirects you back to signin page" do
      current_path.should eq(new_user_session_path)

      # make sure you have proper flash message.
      page.should have_selector('.alert', text: I18n.t('pages.signin.flash.unauthorized'))
    end

  end

  context "while signed in" do
    before { signin_user }

    it "gets you your contact page" do
      # check for proper title
      page_have_title(I18n.t('pages.contacts.title'))

      # be sure correct assets included
      page_have_script('application')
      page_have_style('application')
      
      page_have_not_script('landing')
      page_have_not_style('landing')
    end

    it "contains application navigation" do
      page.should have_xpath('//nav')

      within('nav') do
        page.should have_content(I18n.t('pages.contacts.nav.status_text', username: user.username ))
        page.should have_link(I18n.t('pages.sign_out_button'))
      end
    end

    it "contains proper contacts listing" do
      page.should have_xpath('//aside')
      page.should have_css('aside.sidebar')

      within('aside') do
        page.should have_content(I18n.t('pages.contacts.sidebar.header'))
        page.should have_selector('.contacts-add')
        page.should have_selector('#contacts')
        page.should have_selector('.import-xml')
      end
    end

    it "contains proper contacts show part" do
      page.should have_xpath('//article')
      page.should have_css('article#contact-show')
    end

    it "doesn't suck on i18n" do
      page.body.should_not match(/translation missing/i)
    end

    it "properly signs you out when you want to" do
      signout_user

      # be sure we are redirected to root path
      current_path.should eq(root_path)
      page_have_title(I18n.t('pages.landing.title'))
    end
  end
end
