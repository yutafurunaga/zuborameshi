class Admin::CommentsController < ApplicationController
  
  
  def index
    @recipe = Recipe.find(params[:recipe_id])
    @comments = @recipe.comments
  end
  

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.find(params[:id])
    @comment.destroy
    redirect_to admin_recipe_comments_path(@recipe), notice: "コメントが削除されました。"

  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end