require 'spec_helper'

describe "Api::UpdateContacts" do
  let(:contact) { FactoryGirl.build(:contact, phone: "905334442211")}

  after { page_is_valid_as_json(response.body) }

  context "without signed in user" do
    before { contact.save! }

    it "gives unauthorized response" do
      put_via_redirect api_contact_path(contact)

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

    let!(:contact_params) do
      { 
        name: "Ahmet", 
        last_name: "FevziyeOglu", 
        phone: "905334443322"    
      }
    end
  
    context "updates correct contact" do
    
      it "with batch" do

        put_via_redirect api_contact_path(contact), { contact: contact_params}
        puts user.contacts.inspect
        updated_contact = user.contacts.where(name: contact_params[:name], last_name: contact_params[:last_name]).first
        updated_contact.should_not be_nil
        updated_contact.name.should eq(contact_params[:name])
        updated_contact.last_name.should eq(contact_params[:last_name])
        updated_contact.phone.should eq(contact_params[:phone])
      end
    
    end

    context "does not update irrelevant contact" do
      let!(:irrelevant_user) { FactoryGirl.create(:user) }
      let!(:irrelevant_contact) do
        FactoryGirl.create(:contact, phone: "905553332211", user: irrelevant_user)
      end

      it "with batch" do
        put_via_redirect api_contact_path(contact), { contact: contact_params }

        user.contacts.where(id: irrelevant_contact.id).first.should be_nil

        puts response.body
      end
    end
  
  end
end
