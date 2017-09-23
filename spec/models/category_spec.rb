require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should validate_presence_of :name }

  context do
    # provide a value for the name field because it's NOT NULL
    subject { described_class.new name: 'name' }

    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
