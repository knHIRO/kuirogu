class Public::CustomersController < ApplicationController
   def show
    @customer = Customer.find(params[:id])
    @postings = @customer.postings.order(id: "DESC")
   end

   def index

    @customers = Customer.all
   end


   def edit
    @customer = Customer.find(params[:id])
   end

   def quit
    @customer = current_customer
    if @customer.update(is_deleted: true)
      sign_out current_customer
    end
     redirect_to root_path

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

   def favorites
      favorites = Favorite.where(customer_id: current_customer.id).pluck(:posting_id)
      @favorite_postings = Posting.find(favorites)
   end

   def search
      @section_title = "「#{params[:search]}」の検索結果"
      @customers = if params[:search].present?
                      Customer.where('last_name LIKE ? OR first_name LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%").page(params[:page])
                   else
                      Customer.none
                   end
   end

    private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :introduction, :is_deleted, :email)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
    redirect_to public_customer_path(current_customer.id)
    end
  end

end
