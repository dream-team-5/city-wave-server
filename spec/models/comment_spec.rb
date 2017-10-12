require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should delegate_method(:as_json).to :decorate }
  
  it { should belong_to :user }

  it { should belong_to :place }

  it { should validate_presence_of :text }

  it { should validate_length_of(:text).is_at_least(0).is_at_most 140 }

  it { should validate_presence_of :date }
end
