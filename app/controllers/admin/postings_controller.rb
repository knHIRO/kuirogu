class Admin::PostingsController < ApplicationController

  def show
    @posting = Posting.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    @postings = Posting.find(params[:id])
    @postings.destroy
    redirect_to admin_posting_path
  end

  private

  def posting_params
    params.require(:posting).permit(:customer_id, :body, :is_active, :profile_image)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
    redirect_to customer_path(current_customer.id)
    end
  end


end
