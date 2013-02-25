class Contact < ActiveRecord::Base
  
  # ACCESSIBLES 
  attr_accessible :name, :last_name, :phone


  # ASSOCIATIONS
  belongs_to :user
  

  # SCOPES
  module ImportManager

    # Reads xml string from Uploaded File.
    def parsed_xml(file)
      file.read
    end

    # Takes xml string, converts to hash, and
    # fetches necessary contacts collection from that hash.
    def contacts_from_xml(xml)
      Hash.from_xml(xml)["contacts"]["contact"]
    end

    # Given a newly parsed hash that consists camelCase keys,
    # sanitizes hash by converting its keys :to_underscore_symbols
    def sanitize(contacts)
      contacts.map do |contact|
        Hash[contact.map { |key, value| [ key.underscore.to_sym, value ] }]
      end
    end
  end

  extend ImportManager


  def self.import_from(xml_file, user)
    xml           = parsed_xml(xml_file)
    contacts_hash = contacts_from_xml(xml)
    contacts      = sanitize(contacts_hash)

    Contact.create(contacts) do |contact|
      contact.user = user
    end

  end


  # VALIDATIONS
  validates  :user, presence: true

  validates  :name, presence: true,
                      format: { with: /\A[a-zA-Z]*\s?[a-zA-Z]*\Z/ },
                      length: { minimum: 2, maximum: 50 }

  validates  :last_name, format: { with: /\A[a-zA-Z\']+\Z/ },
                         length: { minimum: 2, maximum: 50 }

  validates  :phone, presence: true,
                       length: { minimum: 10, maximum: 19 }
                         
  validates  :phone, format: { with: /\A[0-9\+\(\)\s]{10,18}\Z/ }

                             
  class PhoneValidator < ActiveModel::Validator
    def validate(record)
      unless record.phone && stripped_size_matches?(record.phone)
        record.errors[:phone] << "Phone must be at least 10 at most 12 digits"
      end
    end

    def stripped_size_matches?(phone)
      phone.gsub(/[^0-9]/,'').size.between?(10, 12)
    end
  end
      
  
  validates_with PhoneValidator


  # HOOKS
  before_save :clean_up_phone

  protected

  def clean_up_phone
    true
  end

end
