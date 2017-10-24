class Admin::Session
  include ActiveModel::Model

  attr_accessor :username, :password

  attr_reader :auth_token, :id

  validates :username, :password, presence: true

  validate :validate_username, :validate_admin, :validate_password

  def initialize params={}
    @username = params[:username]

    @password = params[:password]
  end

  def save
    return false unless valid?

    @persisted = !!create_auth_token
  end

  def persisted?
    !!@persisted
  end

  private
  def user
    @user ||= User.find_by username: username if username.present?
  end

  def validate_username
    if username.present?
      errors.add :username, I18n.t('errors.messages.invalid') if user.blank?
    end
  end

  def validate_admin
    if user.present?
      errors.add :username, I18n.t('errors.messages.invalid') unless user.admin?
    end
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
