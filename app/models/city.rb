class City < ApplicationRecord
  has_many :places, dependent: :destroy

  validates :name, presence: true
end
