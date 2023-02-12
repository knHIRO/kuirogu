class Public::CustomersController < ApplicationController
   def show
    @customer = Customer.find(params[:id])
    @postings = @customer.postings
    #@postings = @customer.postings
    #@posting = Posting.new
   end


   def edit
    @customer = Customer.find(params[:id])
   end

   def update
      @customer = Customer.find(params[:id])
     if @customer.update(customer_params)
      flash[:notice]="You have updated customer successfully."
      redirect_to public_customer_path(@customer.id)
     else
      render :edit
     end
   end

    private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :introduction, :is_deleted, :profile_image)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
    redirect_to public_customer_path(current_customer.id)
    end
  end

end
