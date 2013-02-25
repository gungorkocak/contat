class ContactsController < ApplicationController
  before_filter :authenticate_user_with_message!

  respond_to :html, :json


  def index
    @contacts = current_user.contacts
    respond_with (@contacts)
  end


  def create
    @contact = current_user.contacts.new(params[:contact])
    @contact.save

    respond_with :api, @contact
  end


  def destroy
    @contact = current_user.find_contact(params[:id])
    @contact.try(:destroy)
    
    respond_with(@contact)
  end


  def update
    @contact = current_user.find_contact(params[:id])
    @contact.try(:update_attributes, params[:contact])
                 
    respond_with(@contact)
  end


  def import
    @contacts = current_user.import_from(params[:contacts])

    flash[:notice] = I18n.t('pages.contacts.import.flash.notice')

    respond_with(@contacts, location: contacts_path)
  
  rescue REXML::ParseException
    redirect_to contacts_path, alert: I18n.t('pages.contacts.import.flash.alert')
  end


  protected


  def authenticate_user_with_message!
    unless user_signed_in?
      respond_to do |format|
        format.html { respond_unauthorized_as_html }
        format.json { respond_unauthorized_as_json }
      end
    end
  end


  def respond_unauthorized_as_html
    flash[:notice] = I18n.t('pages.signin.flash.unauthorized')
    redirect_to new_user_session_path
  end


  def respond_unauthorized_as_json
    render json: { error: I18n.t('api.errors.unauthorized')}.to_json, status: :unauthorized 
  end
end
