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

  def withdraw
    @customer = Customer.find(params[:id])
    # 退会処理の実装
    if @customer.update(is_deleted: true)
       reset_session
      # 退会が成功した場合の処理
      # 例えば、トップページにリダイレクトするなど
      redirect_to home_about_path, notice: '退会が完了しました。'
    else
      # 退会が失敗した場合の処理
      # 例えば、エラーメッセージを表示するなど
      redirect_to customer_path(@customer), alert: '退会に失敗しました。'
    end
  end

   private

  def customer_params
    params.require(:customer).permit(:email, :family_name, :personal_name, :family_name_kana, :personal_name_kana)
  end
end
