require 'rails_helper'

RSpec.describe City, type: :model do
  it { should delegate_method(:as_json).to :decorate }

  it { should have_many(:places).dependent :destroy }

  it { should validate_presence_of :name }
end
