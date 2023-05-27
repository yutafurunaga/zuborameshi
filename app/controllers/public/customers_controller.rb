class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, only: [:edit]
  
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @recipes = @customer.recipes
    @comments = @customer.comments
    @editable = current_customer == @customer # 現在のカスタマーと表示対象のカスタマーを比較
  end

  def edit
     @customer = Customer.find(params[:id])
     unless current_customer == @customer
      redirect_to customer_path(@customer), alert: "他のユーザーの編集はできません。"
      return
    end
  end

  def update
     @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to @customer, notice: "登録情報を変更しました"
    else
      render :edit
    end
  end
  
  def unsubscribe
    # 退会画面の表示
  end

 def withdrawal
    current_customer.withdraw
    current_customer.recipes.destroy_all
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

   private

  def customer_params
    params.require(:customer).permit(:email, :family_name, :personal_name, :family_name_kana, :personal_name_kana)
  end
end
