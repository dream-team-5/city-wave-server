require 'rails_helper'

RSpec.describe CategoryPolicy do
  subject { described_class }

  permissions :index? do
    it { should_not permit nil, nil }

    it { should permit double, nil }
  end
end
