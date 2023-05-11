class Public::CommentsController < ApplicationController
  
  def create
  @recipe = Recipe.find(params[:recipe_id])
  @comment = @recipe.comments.build(comment_params)
  @comment.customer_id = current_customer.id
  if @comment.save
    redirect_to recipe_path(@recipe)
  else
    render 'recipes/show'
  end
end

private
def comment_params
  params.require(:comment).permit(:comment)
end
end
