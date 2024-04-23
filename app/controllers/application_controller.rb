class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :redirect_if_buffet_owner_without_buffet

    private
  
    def redirect_if_buffet_owner_without_buffet
      unless params[:controller] == 'buffets' && ['new', 'create'].include?(params[:action])
        if current_user&.role == 'buffet_owner' && !Buffet.exists?(user_id: current_user.id)
          redirect_to new_buffet_path, notice: 'Você precisa cadastrar um buffet para continuar.'
        end
      end
    end
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :name, :cpf])
    end
end
