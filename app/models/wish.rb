class Wish < ApplicationRecord
  validates :text, presence: true
end
