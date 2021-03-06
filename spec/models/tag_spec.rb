require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { should delegate_method(:as_json).to :decorate }
  
  it { should have_and_belong_to_many :places }

  it { should validate_presence_of :name }
end
