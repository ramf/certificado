class AssociateController < ApplicationController
  before_action :set_options, only: [:associate]
  before_action :set_user_agreements, only: [:index]

  def index
    @nome_completo = Devise::LDAP::Adapter.get_ldap_param(current_user.username,"cn").first.force_encoding("utf-8")
    @people = User.all;
    @agreements = Agreement.all;
    if(@user.id != 0)
      @agreements = @agreements.select{|agrement| !@user.agreements.any? {|ag| ag.id == agrement.id } }
    end
  end

  def associate
    @user.agreements << @agreement
    redirect_to action: 'index', user: @user.id
  end

  private
    def set_options
      @agreement = Agreement.find(params['agreement'])
      @user = User.find(params['user'])
    end

    def set_user_agreements
      if(params['user'] != nil)
        @user = User.find(params['user'])
        @userAgreements = @user.agreements
      else
        @userAgreements = Array.new;
        @user = User.new;
        @user.id = 0;
      end
    end
end
