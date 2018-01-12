class ApplicationController < ActionController::Base
  include Pundit
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
protect_from_forgery with: :exception
before_action :authenticate_user!

before_action :configure_permitted_parameters, if: :devise_controller?
  #Pundit


#Gerencia erros do Pundit
rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def configure_permitted_parameters
      # devise 4.3 .for method replaced by .permit
      devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
      #devise_parameter_sanitizer.for(:sign_in) << :username
    end

    private
      def set_active_controller_action
        if params[:controller] && params[:action] && current_user
          current_user.active_controller_action = params[:controller] + "/" + params[:action]
        end
      end

      def user_not_authorized
        flash[:error] = "Ação não autorizada"
        redirect_to(request.referrer || root_path)
      end

  end
