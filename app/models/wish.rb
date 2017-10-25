class Wish < ApplicationRecord
  delegate :as_json, to: :decorate

  validates :text, presence: true

  paginates_per 8
end
