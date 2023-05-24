class Public::RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_customer!, except: [:index, :show]
  before_action :authorize_customer, only: [:edit, :update, :destroy]
  
  def new
    @recipe = Recipe.new
    @recipe.ingredients.build
    @recipe.steps.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    @recipe.tag_list.add(params[:tag_list])
    if @recipe.save!
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def index
   if params[:tag].present?
      @recipes = Recipe.tagged_with(params[:tag]).page(params[:page]).per(10)
   else
      @recipes = Recipe.page(params[:page]).per(10)
   end
  end


  def show
    @recipe = Recipe.find(params[:id])
    @customer = @recipe.customer
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @recipe.ingredients.build
    @recipe.steps.build

  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      # binding.irb
      redirect_to @recipe, notice: "Recipe updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: 'レシピを削除しました。'
  end

  def favorite
  @favorite_recipes = current_customer.favorite_recipes
  end

  private

  def set_recipe
   @recipe = Recipe.find(params[:id])
  end
  
  def authorize_customer
    unless @recipe.customer == current_customer
      redirect_to @recipe, alert: '他のユーザーのレシピは編集できません。'
    end
  end

 def recipe_params
    params.require(:recipe).permit(:customer_id, :dish_name, :recipe_description, :photo, :tag_list,
    ingredients_attributes: [:id, :recipe_id, :ingredient_name, :quantity, :_destroy],
    steps_attributes: [:id, :recipe_id, :instruction, :_destroy])
 end
end
