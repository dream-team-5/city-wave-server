require 'rails_helper'

RSpec.describe Admin::SessionPolicy do
  subject { described_class }

  permissions :new?, :create? do
    it { should permit nil, nil }
  end

  permissions :show? do
    it { should_not permit nil, nil }

    it { should_not permit stub_model(User), double }

    it { should permit stub_model(User, roles: :admin), double }
  end
end
