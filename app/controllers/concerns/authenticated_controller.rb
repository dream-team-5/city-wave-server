module AuthenticatedController
  extend ActiveSupport::Concern

  included do
    helper_method :current_user

    before_action :authenticate
  end

  private
  def auth_token
    @auth_token ||= params[:token] || session[:token]
  end

  def current_user
    if auth_token.present?
      @current_user ||= find_user_by_auth_token || find_basic_user_by_id
    end
  end

  def find_user_by_auth_token
    User.joins(:auth_tokens).find_by auth_tokens: { id: auth_token }
  end

  def find_basic_user_by_id
    user = User.find_by id: auth_token

    user unless user&.registered?
  end

  def authenticate
    unless current_user
      respond_to do |format|
        format.json { render_error 'Auth token is not valid', 401 }

        format.any(:js, :html) { redirect_to [:new, :admin, :session] }
      end
    end
  end
end
