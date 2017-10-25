require 'rails_helper'

RSpec.describe WishPolicy do
  subject { described_class }

  permissions :index? do
    it { should_not permit nil, nil }

    it { should_not permit stub_model(User), nil }

    it { should permit stub_model(User, roles: :basic), nil }
  end

  permissions :show?, :new?, :create?, :edit?, :update?, :destroy? do
    it { should_not permit nil, nil }

    it { should_not permit stub_model(User), double }

    it { should permit stub_model(User, roles: :admin), double }
  end
end
