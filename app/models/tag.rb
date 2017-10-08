class Tag < ApplicationRecord
  delegate :as_json, to: :decorate

  has_and_belongs_to_many :places

  validates :name, presence: true
end
