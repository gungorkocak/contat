require 'spec_helper'
require 'multi_json'

describe "Api::Contacts" do
  it "does not suck on I18n" do
    visit api_contacts_path
    page.body.should_not match(/translation missing/)
  end

  after { page_is_valid_as_json(page.body) }

  context "with not signed in user" do
    before { visit api_contacts_path }

    it "gives unauthorized response" do
      # WTF? why should I call to_json two times?
      error = { error: I18n.t('api.errors.unauthorized') }.to_json
      page.body.to_json.should include_json(error.to_json)
    end
  end

  context "with signed in user" do
     
    before { signin_user }

    context "that has 20 contacts" do
      let!(:unrelated_user) { FactoryGirl.create(:user) }
      let!(:contacts) { FactoryGirl.create_list(:contact, 20, user: user, phone: "905332221100") } 
      let!(:unrelated_contacts) { FactoryGirl.create_list(:contact, 20, user: unrelated_user, phone: "905332221100") }

      it "contains all of the related contacts" do
        visit api_contacts_path
        page.body.to_json.should include_json(contacts.to_json.to_json)
      end

      it "doesn't contain any of the unrelated contacts" do
        visit api_contacts_path
        page.body.to_json.should_not include_json(unrelated_contacts.to_json.to_json)
      end

    end
  end
end
