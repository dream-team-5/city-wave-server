class Wish < ApplicationRecord
  delegate :as_json, to: :decorate
  
  validates :text, presence: true
end
