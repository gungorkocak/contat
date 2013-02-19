class PagesController < ApplicationController
  layout 'landing'

  before_filter :redirect_to_contacts, only: [:landing]
  def landing
  end

  protected

  def redirect_to_contacts
    redirect_to(contacts_path) if user_signed_in? 
  end
end
