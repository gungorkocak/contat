require 'spec_helper'

describe "ImportContacts" do
  let(:xml_file) do
    xml_path = "#{Rails.root}/spec/support/files/proper_contacts.xml"
    fixture_file_upload(xml_path, 'application/xml')
  end


  context "without signedin user" do
  
    it "gives unauthorized response" do
      post_via_redirect import_contacts_path, contacts: xml_file

      response.body.should match(I18n.t('pages.signin.flash.unauthorized'))
    end
  
  end

  context "with signed in user" do
    before do
      signin_user 
      visit root_path
    end

    # Policy: Accept all or reject all.
    
    context "by passing proper xml" do
      let(:proper_xml_path) { "#{Rails.root}/spec/support/files/proper_contacts.xml" }

      subject(:importing_proper_xml) do
        lambda {
          attach_file('contacts', proper_xml_path)
          click_on "Import Contacts From XML" 
        }
      end

      it { should change(Contact, :count) }

      it "properly notifies user" do
        subject.call
        page.body.should match(I18n.t('pages.contacts.import.flash.notice'))
      end

    end

    context "by passing corrupted xml that lacks contacts wrapper tag" do
      let(:lacking_xml_path) { "#{Rails.root}/spec/support/files/corrupted_contacts_tree.xml" }

      subject do
        lambda {
          attach_file('contacts', lacking_xml_path)
          click_on "Import Contacts From XML"
        }
      end

      it { should_not change(Contact, :count) } 

      it "properly notifies user about corrupted state of the file" do
        subject.call
        page.body.should match(I18n.t('pages.contacts.import.flash.alert'))
      end
      
    end

    context "by passing corrupted xml that has corrupted <contact> tag", wip: true do
      let(:corrupted_element_xml_path) { "#{Rails.root}/spec/support/files/corrupted_contacts_element.xml" }

      subject do
        lambda {
          attach_file('contacts', corrupted_element_xml_path)
          click_on "Import Contacts From XML"
        }
      end

      it { should_not change(Contact, :count) } 

      it "properly notifies user about corrupted state of the file" do
        subject.call
        page.body.should match(I18n.t('pages.contacts.import.flash.alert'))
      end
      
    end
  end
end
