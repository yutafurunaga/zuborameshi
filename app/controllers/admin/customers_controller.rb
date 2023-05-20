class Admin::CustomersController < ApplicationController
  
  def show
    @customer = Customer.find(params[:id])
    @recipes = @customer.recipes
  end
  
  def edit
     @customer = Customer.find(params[:id])
  end
  
  def update
     @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path, notice: "登録情報を変更しました"
    else
      render :edit
    end
  end


    private
    
    def customer_params
      params.require(:customer).permit(:family_name, :personal_name, :family_name_kana, :personal_name_kana, :email, :status)
    end

end