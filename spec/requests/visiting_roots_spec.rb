require 'spec_helper'

describe "VisitingRoots" do

  describe "without signin", wip: true do

    before { visit root_path }

    it "gets you to the landing page" do
      # save_and_open_page

      # check for proper title
      page_have_title(I18n.t('pages.landing.title'))

      # be sure correct js and style files included
      page_have_script('landing')
      page_have_style('landing')

      page_have_not_script('application')
      page_have_not_style('application')

    end

    it "contains landing navigation" do
      page.should have_xpath('//nav')

      within('nav') do
        page.should have_content(I18n.t('pages.sign_in_text'))
        page.should have_link(I18n.t('pages.sign_in_button'))
      end
    end

    it "contains proper call-to-action section" do
      page.should have_selector('.call-to-action')

      within('.call-to-action') do
       page.should have_link(I18n.t('pages.landing.call_to_action.start'))
       page.should have_selector('.message', text: I18n.t('pages.landing.call_to_action.message'))
      end
    end

    it "doesnt suck on i18n" do
      page.body.should_not match(/translation missing/i)
    end
  end

  describe "while signed in" do
    before { signin_user }

    it "redirects to contacts page" do
      visit root_path
      current_path.should eq(contacts_path)
    end
  end
end
