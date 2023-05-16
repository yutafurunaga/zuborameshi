class Admin::CustomersController < ApplicationController
  
  def show
    @customer = Customer.find(params[:id])
    @recipes = @customer.recipes
  end
end
