class Public::RanksController < ApplicationController
  
  def rank
  # いいね数ランキング
  @favorite_recipe_ranks = Recipe.find(Favorite.group(:recipe_id).order('count(recipe_id) desc').pluck(:recipe_id))
  end
  

end
