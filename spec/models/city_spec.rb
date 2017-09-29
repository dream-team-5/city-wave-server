require 'rails_helper'

RSpec.describe City, type: :model do
  it { should have_many :places }

  it { should validate_presence_of :name }
end
