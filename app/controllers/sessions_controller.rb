class SessionsController < Devise::SessionsController
  layout 'landing'

  # POST /users/sign_in
  def create
    unless self.resource = warden.authenticate(auth_options)
      self.resource = User.new  # give a newborn User for form control
      flash[:alert] = I18n.t('pages.signin.flash.error')
      render :new and return
    end

    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => after_sign_in_path_for(resource)
  end

  private

end
