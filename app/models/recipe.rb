class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true

   has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :steps, reject_if: :all_blank, allow_destroy: true

  belongs_to :customer
  has_many :comments

  has_one_attached :photo
end