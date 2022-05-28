class Public::CustomersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit, :show]

  def show
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    if @customer.update(customer_params)
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end

  def ensure_correct_user
    @customer = current_customer
    unless @customer == current_customer
      redirect_to customer_path(current_user)
    end
  end
end
