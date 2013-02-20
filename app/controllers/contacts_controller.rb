class ContactsController < ApplicationController
  before_filter :authenticate_user_with_message!

  def index
  end

  protected

  def authenticate_user_with_message!
    unless user_signed_in?
      flash[:notice] = I18n.t('pages.signin.flash.unauthorized')
      redirect_to new_user_session_path
    end
  end
end
