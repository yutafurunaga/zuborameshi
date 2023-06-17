class Public::CommentsController < ApplicationController
  before_action :set_recipe
  before_action :set_comment, only: [:edit, :update, :destroy]
  
  def index
    @comments = @recipe.comments
  end
  
  def create
    @comment = @recipe.comments.build(comment_params)
    @comment.customer = current_customer

    if @comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      render "public/comments/recipes_comments"  #render先にjsファイルを指定
    else
      render "recipes/show"
    end
  end
  
  def edit
  end
  
  def update
    if @comment.update(comment_params)
      redirect_to recipe_path(@recipe), notice: "コメントが更新されました"
    else
      render :edit
    end
  end
  
  def destroy
    @comment.destroy
    flash.now[:alert] = '投稿を削除しました'
    # redirect_to recipe_path(@recipe), notice: "コメントが削除されました"
    render "recipes_comments"
  end

private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
  
  def set_comment
    @comment = @recipe.comments.find(params[:id])
  end

  def comment_params
      params.require(:comment).permit(:comment)
  end
end
