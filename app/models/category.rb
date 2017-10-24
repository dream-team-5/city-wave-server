class Category < ApplicationRecord
  delegate :as_json, to: :decorate

  has_many :places

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  paginates_per 8
end
