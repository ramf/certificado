class ApplicationController < ActionController::Base

  #Pundit
  include Pundit

  #Gerencia erros do Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private

    def user_not_authorized
      flash[:notice] = "Você não está autorizado a executar essa ação."
      redirect_to(request.referrer || root_path)
      end
    end
