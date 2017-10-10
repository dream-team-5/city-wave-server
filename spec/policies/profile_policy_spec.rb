require 'rails_helper'

RSpec.describe ProfilePolicy do
  subject { described_class }

  permissions :create? do
    it { should permit nil, nil }
  end

  permissions :show?, :update? do
    it { should permit stub_model(User, roles: :basic), nil }

    it { should_not permit stub_model(User), nil }
  end
end
