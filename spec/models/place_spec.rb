require 'rails_helper'

RSpec.describe Place, type: :model do
  it { should belong_to :city }

  it { should belong_to :category }

  it { should have_many :comments }

  it { should have_attached_file :photo }

  it { should have_and_belong_to_many :tags }

  it { should validate_attachment_presence :photo }

  it { should validate_attachment_content_type(:photo).allowing('image/gif', 'image/jpeg', 'image/png') }

  it { should validate_attachment_size(:photo).in(0..5.megabytes) }

  it { should validate_presence_of :name }

  it { should validate_presence_of :description }

  it { should validate_presence_of :address }

  it { should validate_presence_of :location }

  it { should validate_numericality_of(:price).is_greater_than(0).allow_nil }
end
