class Api::Profile
  delegate_missing_to :user

  def initialize user
    @user = user
  end

  def policy_class
    Api::ProfilePolicy
  end

  def update params
    if registered?
      update_registered params
    elsif basic?
      create_registered params
    else
      false
    end
  end

  private
  def user
    @user ||= User.new roles: :basic
  end

  def create_registered params
    params = {
      password: params.require(:password),
      username: params.require(:username)
    }

    user.roles << :registered

    user.update params
  end

  def update_registered params
    return false unless user.authenticate params.require :password

    user.update password: params[:new_password],
                username: params[:username]
  end
end
