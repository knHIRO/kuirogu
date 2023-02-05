class Public::CustomersController < ApplicationController
   def show
    @customer = current_customer
    #@postings = @customer.postings
    #@posting = Posting.new
    @customers =Customer.all
   end


   def edit
    @customer = current_customer
   end

   def update
      @customer = current_customer
     if @customer.update(customer_params)
      flash[:notice]="You have updated customer successfully."
      redirect_to public_customers_path(@customer.id)
     else
      render :edit
     end
   end

    private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :introduction, :is_deleted, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
    redirect_to user_path(current_user.id)
    end
  end

end
