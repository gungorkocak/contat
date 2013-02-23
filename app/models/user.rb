class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :registerable, :rememberable, :validatable,
         :database_authenticatable, authentication_keys: [:username]
  

  attr_accessible :username, :password, :password_confirmation, :remember_me


  # VALIDATIONS
  validates :username,  presence: true,
                        uniqueness: true,
                        format: { with: /\A[_a-zA-Z0-9]+\Z/ },
                        length: { minimum: 3, maximum: 50 }


  # ASSOCIATIONS
  has_many :contacts, dependent: :destroy


  # SCOPES
  def find_contact(id); contacts.where(id: id).first end 


  # HACKS TO GET DEVISE USERNAME AUTH WORKING 
  def email_required?; false end
  def email_changed?; false end
end
