class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if resource.role == 'buffet_owner' && resource.buffet.nil?
        new_buffet_path
    else
        root_path
    end
  end
end