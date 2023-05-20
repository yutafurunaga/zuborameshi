class Admin::RecipesController < ApplicationController


  def show
    @recipe = Recipe.find(params[:id])
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @customer = @recipe.customer
    @recipe.destroy
    redirect_to admin_customer_path(@customer), notice: 'レシピを削除しました。'
  end
end
