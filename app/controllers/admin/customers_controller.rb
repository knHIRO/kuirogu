class Admin::CustomersController < ApplicationController
   def show
    #@customer = Customer.new
    @customer = Customer.find(params[:id])
    @postings = @customer.postings
   end

   def edit
    @customer = Customer.find(params[:id])
    @customers = Customer.find(params[:id])
   end

   def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      #flash[:notice]="You have updated user successfully."
      redirect_to admin_customer_path(@customer.id)
    else
      render :edit
    end
   end

   private

   def customer_params
     params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :introduction, :is_deleted, :email)
   end
end
