class Profile
  include Draper::Decoratable

  attr_reader :password, :username, :errors

  delegate :id, :username, to: :user, prefix: true

  delegate :as_json, to: :decorate

  def initialize user
    @user = user
  end

  def save
    valid = user.save

    @errors = user.errors

    valid
  end

  def update params
    parse_params params

    if user.registered?
      update_registered
    else
      update_basic
    end

    save
  end

  private
  def user
    @user ||= User.new roles: :basic
  end

  def parse_params params
    @password = params[:password]

    @username = params[:username]
  end

  def update_basic
    user.roles << :registered

    user.password = password

    user.username = username
  end

  def update_registered
    user.password = password if password.present?

    user.username = username if username.present?
  end
end
