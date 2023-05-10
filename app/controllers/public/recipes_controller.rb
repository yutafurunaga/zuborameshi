class Public::RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  
  def new
    @recipe = Recipe.new
    @recipe.ingredients.build
    @recipe.steps.build
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end
  
  def index
    @recipes = Recipe.all
  end


  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @recipe.ingredients.build
  
  end
  
  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: 'Recipe was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @recipe.destroy
    redirect_to recipes_url, notice: 'Recipe was successfully destroyed.'
  end

  private
  
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

 def recipe_params
    params.require(:recipe).permit(:customer_id, :dish_name, :recipe_description, ingredients_attributes: [:id, :recipe_id, :ingredient_name, :quantity, :_destroy], steps_attributes: [:id, :recipe_id, :instruction, :_destroy])
 end
end
