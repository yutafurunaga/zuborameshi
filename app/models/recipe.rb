class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true

   has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :steps, reject_if: :all_blank, allow_destroy: true

  belongs_to :customer
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  acts_as_taggable_on :tags
  
  
  def self.looks(search, word)
    if search == "perfect_match"
      @recipe = Recipe.where("dish_name LIKE?","#{word}")
    elsif search == "forward_match"
       @recipe = Recipe.where("dish_name LIKE?","#{word}%")
    elsif search == "backward_match"
       @recipe = Recipe.where("dish_name LIKE?","%#{word}")
    elsif search == "partial_match"
       @recipe = Recipe.where("dish_name LIKE?","%#{word}%")
    else
       @recipe = Recipe.all
    end
  end

  def favorited_by?(customer)
    #byebug
    favorites.exists?(customer_id: customer.id)
  end
   has_one_attached :photo
end