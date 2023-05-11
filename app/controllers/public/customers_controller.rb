class Public::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end
  
  def show
    @customer = Customer.find(params[:id])
    @recipes = @customer.recipes
    @comments = @customer.comments
  end
  
  def edit
     @customer = Customer.find(params[:id])
  end
  
  def update
     @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to @customer, notice: "登録情報を変更しました"
    else
      render :edit
    end
  end
   
   private

  def customer_params
    params.require(:customer).permit(:email, :family_name, :personal_name, :family_name_kana, :personal_name_kana)
  end
end
