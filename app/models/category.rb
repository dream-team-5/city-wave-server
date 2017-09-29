class Category < ApplicationRecord
  has_many :places

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
