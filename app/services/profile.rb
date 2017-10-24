class Profile
  attr_reader :password, :username, :id

  delegate :save, :errors, :decorate, to: :user

  delegate :as_json, to: :decorate

  def initialize user=nil
    @user = user
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

  def user
    @user ||= User.new roles: :basic
  end

  private
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
