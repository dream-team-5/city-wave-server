require 'rails_helper'

RSpec.describe SessionPolicy do
  subject { described_class }

  permissions :create? do
    it { should permit nil, nil }
  end
end
