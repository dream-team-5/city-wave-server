module AuthenticatedController
  extend ActiveSupport::Concern

  included do
    helper_method :current_user

    before_action :authenticate
  end

  private
  def current_user
    if params[:auth_token].present?
      @current_user ||= find_user_by_auth_token || find_basic_user_by_id
    end
  end

  def find_user_by_auth_token
    User.joins(:auth_tokens).find_by auth_tokens: { id: params[:auth_token] }
  end

  def find_basic_user_by_id
    user = User.find_by id: params[:auth_token]

    user unless user&.registered?
  end

  def authenticate
    head :unauthorized unless current_user
  end
end
