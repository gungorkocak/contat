class Contact < ActiveRecord::Base
  
  # ACCESSIBLES & SCOPES
  attr_accessible :name, :last_name, :phone


  # ASSOCIATIONS
  belongs_to :user
  

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
