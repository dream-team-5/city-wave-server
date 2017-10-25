class City < ApplicationRecord
  delegate :as_json, to: :decorate

  has_many :places, dependent: :destroy

  validates :name, presence: true

  paginates_per 8
end
