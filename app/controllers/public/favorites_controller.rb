class Public::FavoritesController < ApplicationController
  def create
    posting = Posting.find(params[:posting_id])
    favorite = current_customer.favorites.new(posting_id: posting.id)
    favorite.save
    # redirect_back fallback_location: root_path
    posting.create_notification_favorite!(current_customer)
  end

  def destroy
    posting = Posting.find(params[:posting_id])
    favorite = current_customer.favorites.find_by(posting_id: posting.id)
    favorite.destroy
    # redirect_back fallback_location: root_path
  end


private
  def set_customer
    @customer = Customer.find(params[:id])
  end
end
