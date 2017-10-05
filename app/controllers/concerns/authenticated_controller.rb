module AuthenticatedController
  extend ActiveSupport::Concern

  included do
    helper_method :current_user

    before_action :authenticate
  end

  private
  def current_user
    @current_user ||= User
      .joins(:auth_tokens)
      .where(auth_tokens: { value: params[:auth_token] })
      .first if params[:auth_token].present?
  end

  def authenticate
    head :unauthorized unless current_user
  end
end
