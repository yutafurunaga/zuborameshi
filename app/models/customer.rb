class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes, dependent: :destroy
  # has_many :foos, dependent: :destroy, class_name: 'Recipe'
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_recipes, through: :favorites, source: :recipe

  def self.looks(search, word)
    @customer = Customer.where("family_name LIKE ? OR personal_name LIKE ?", "%#{word}%", "%#{word}%")
  end
  
end
