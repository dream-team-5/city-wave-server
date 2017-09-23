class Place < ApplicationRecord
  belongs_to :city

  belongs_to :category

  has_attached_file :photo

  validates_attachment :photo, presence: true,
    content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] },
    file_name: { matches: [/jpe?g\z/, /gif\z/, /png\z/] },
    size: { in: 0..5.megabytes }

  validates :name, presence: true

  validates :description, presence: true

  validates :address, presence: true

  validates :location, presence: true

  validates :price, numericality: { greater_than: 0 }, allow_nil: true
end
