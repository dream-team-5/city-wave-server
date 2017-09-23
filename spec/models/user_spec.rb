require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :roles }

  context do
    subject { described_class.new roles: :registered }

    it { should have_secure_password }

    it { should validate_presence_of :username }

    it { should validate_length_of(:username).is_at_least(2).is_at_most 20 }

    it { should validate_uniqueness_of(:username).case_insensitive }
  end
end
