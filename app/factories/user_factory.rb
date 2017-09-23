class UserFactory < ApplicationFactory
  private
  def params
    @params.merge(roles: :basic)
  end
end
