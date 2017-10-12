require 'rails_helper'

RSpec.describe CommentPolicy do
  subject { described_class }

  permissions :index? do
    it { should_not permit nil, nil }

    it { should_not permit stub_model(User), nil }

    it { should permit stub_model(User, roles: :basic), nil }
  end

  permissions :create? do
    it { should_not permit nil, nil }

    it { should_not permit stub_model(User), nil }

    it { should_not permit stub_model(User, roles: :basic), nil }

    it { should permit stub_model(User, roles: [:basic, :registered]), nil }
  end
end
