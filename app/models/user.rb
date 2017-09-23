class User < ApplicationRecord
  delegate :is_basic?, :is_registered?, :is_admin?, to: :decorate

  has_and_belongs_to_many :visited_places, class_name: 'Place', join_table: :visited_places

  has_and_belongs_to_many :saved_places, class_name: 'Place', join_table: :saved_places

  has_many :comments

  bitmask :roles, as: [:admin, :basic, :registered]

  has_secure_password validations: false

  validates :roles, presence: true

  with_options if: :is_registered? do |model|
    model.validate do |record|
      record.errors.add :password, :blank unless record.password_digest.present?
    end

    model.validates_length_of :password,
      maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED

    model.validates :username,
      presence: true,
      length: { in: 2..20 },
      uniqueness: { case_sensitive: false }
  end
end
