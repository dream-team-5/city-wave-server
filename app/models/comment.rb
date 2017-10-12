class Comment < ApplicationRecord
  delegate :as_json, to: :decorate

  belongs_to :user

  belongs_to :place

  validates :text, presence: true, length: { in: 0..140 }

  validates :date, presence: true
end
