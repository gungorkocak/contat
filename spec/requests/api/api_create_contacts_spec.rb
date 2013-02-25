require 'spec_helper'

describe "Api::CreateContacts" do
  let(:contact_param) do
    { name: "Ahmet", last_name: "Frizbioglu", phone: "905332223454" }
  end

  after { page_is_valid_as_json(response.body) }

  context "without signed in user" do
    it "gives unauthorized response" do
      post api_contacts_path, { contact: contact_param }

      error = { error: I18n.t('api.errors.unauthorized') }.to_json
      response.body.to_json.should include_json(error.to_json)
    end
  end

  context "with signed in user" do
    before { signin_user motive: :rack_test }

    context "when it is valid" do
      before { post api_contacts_path, { contact: contact_param } }

      it "saves it" do
        contact = user.contacts.where(name: contact_param[:name], last_name: contact_param[:last_name])

        contact.should be_present
      end
    end

    context "when it is not valid" do
      it "doesnt suck on i18n" do
        invalid_contact = { name: "asd254^$", last_name: "reti&*34", phone: "902345" }

        post api_contacts_path, { contact: invalid_contact }
        puts response.body.should_not match(/translation missing/)
      end

      context " with #name" do
        let(:invalid_name) { "aldo$%^" }
        before do
          post api_contacts_path, { contact: contact_param.merge(name: invalid_name) } 
        end

        it "gives proper error" do

          # @todo: use json_spec efficiently with paths.
          #        research why it is not correct.
          # response.body.to_json.should have_json_path('errors/name') 

          response.body.should match(/errors/)
          response.body.should match(/name/)
        end

        it "doesn't save it" do
          Contact.where(name: invalid_name).first.should be_nil
        end
      end
      
      context " with #last_name" do
        let(:invalid_last_name) { "F1ri*zf*ck" }
        before do
          post api_contacts_path, { contact: contact_param.merge(last_name: invalid_last_name) } 
        end

        it "gives proper error" do
          response.body.should match(/errors/)
          response.body.should match(/last_name/)
        end

        it "doesn't save it" do
          Contact.where(name: invalid_last_name).first.should be_nil
        end
      end
      
      context " with #phone" do
        let(:invalid_phone) { "phone3433" }

        before do
          post api_contacts_path, { contact: contact_param.merge(phone: invalid_phone) } 
        end

        it "gives proper error" do
          response.body.should match(/errors/)
          response.body.should match(/phone/)
        end

        it "doesn't save it" do
          Contact.where(phone: invalid_phone).first.should be_nil
          Contact.where(phone: invalid_phone.gsub(/[^0-9]/, '')).first.should be_nil
        end
      end
    end
  end
end
