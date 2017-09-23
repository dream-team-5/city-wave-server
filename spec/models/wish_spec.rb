require 'rails_helper'

RSpec.describe Wish, type: :model do
  it { should validate_presence_of :text }
end
