require 'spec_helper'

describe "Api::DestroyContacts" do
  # @todo: Enough of this faker invalid phones!
  #        When you have time open a pull request,
  #        add tr.yml to faker gem.  
  let(:contact) { FactoryGirl.build(:contact, phone: "905334443322") }
  
  after { page_is_valid_as_json(response.body) }
  
  context "without signed in user" do
    before { contact.save! }

    it "give unauthorized response" do
      delete_via_redirect api_contact_path(contact)
      
      error = { error: I18n.t('api.errors.unauthorized') }.to_json
      response.body.to_json.should include_json(error.to_json)
    end
  end

  context "with signed in user" do
    before do
      signin_user motive: :rack_test 
      contact.user = user
      contact.save!
    end

    let!(:irrelevant_user) do
      FactoryGirl.create(:user)
    end

    let!(:irrelevant_contact) do
      FactoryGirl.create(:contact, phone: "905334442211", user: irrelevant_user)
    end

    it "destroys correct contact" do
      delete_via_redirect api_contact_path(contact)

      user.contacts.where(id: contact.id).first.should be_nil
    end

    it "does not destroy irrelevant contact" do
      puts irrelevant_contact.inspect
      delete_via_redirect api_contact_path(irrelevant_contact)

      puts response.body
    end
  end
end
