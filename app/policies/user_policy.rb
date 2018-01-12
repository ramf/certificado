class UserPolicy < ApplicationPolicy

  def index?
    user.full_access?
  end

  def new?
    user.full_access?
  end

  def edit?
    user.full_access?
  end

  def destroy?
    user.full_access?
  end

  def export?
    user.full_access?
  end

  def send_email?
    user.full_access?
  end

  def associate?
    user.full_access?
  end

  def permitted_attributes
  if sAMAccountName=900828
    [:name, :email, :role, :password, :password_confirmation]
  else
    [:name, :email, :password, :password_confirmation]
  end
end

class Scope < Scope
  def resolve
    if user.full_access?
      scope.all
    else
      scope.with_restricted_access
    end
  end
end
end
