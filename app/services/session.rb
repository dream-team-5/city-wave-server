class Session
  include ActiveModel::Model

  attr_accessor :username, :password

  attr_reader :auth_token

  validates :username, :password, presence: true

  validate :validate_username, :validate_password

  def initialize params
    @username = params[:username]

    @password = params[:password]
  end

  def save
    return false unless valid?

    !!create_auth_token
  end

  private
  def user
    @user ||= User.find_by username: username if username.present?
  end

  def validate_username
    errors.add :username, I18n.t('errors.messages.invalid') if user.blank?
  end

  def validate_password
    if password.present? && !user&.authenticate(password)
      errors.add :password, I18n.t('errors.messages.invalid')
    end
  end

  def create_auth_token
    auth_token = user.auth_tokens.create

    @auth_token = auth_token.id if auth_token.persisted?
  end
end
