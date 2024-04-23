class RegistrationsController < Devise::RegistrationsController
  def new_buffet_owner
    build_resource
    self.resource.role = 'buffet_owner'
    respond_with self.resource
  end

  def new_client
    build_resource
    self.resource.role = 'client'
    respond_with self.resource
  end
  protected

  def after_sign_up_path_for(resource)
    if resource.role == 'buffet_owner' && resource.buffet.nil?
        new_buffet_path
    else
        root_path
    end
  end

  def client_path_for_login_and_register(resource)
    if resource.role == 'client'
      root_path
    else
      new_buffet_path
    end
  end
end