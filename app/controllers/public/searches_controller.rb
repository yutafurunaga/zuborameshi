class Public::SearchesController < ApplicationController
before_action :authenticate_customer!
#   def search
#     if params[:keyword].present? # キーワード検索
#       @recipes = Recipe.where('dish_name LIKE ?', "%#{params[:keyword]}%")
#     else
#       @recipes = Recipe.all
#     end
#   end
def search
    @range = params[:range]

    if @range == "customer"
      @customer = Customer.looks(params[:search], params[:word])
    else
      @recipes = Recipe.looks(params[:search], params[:word])
    end
  end


end
