class Public::FavoritesController < ApplicationController
  
  def create
    @recipe = Recipe.find(params[:recipe_id])
    favorite = current_customer.favorites.new(recipe_id: @recipe.id)
    favorite.save
    redirect_to @recipe
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    favorite = current_customer.favorites.find_by(recipe_id: @recipe.id)
    favorite.destroy
    redirect_to @recipe
  end
end
