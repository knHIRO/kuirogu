class Admin::PostingsController < ApplicationController
  def index
    @postings = Posting.all
  end

  def destroy
    @postings = Posting.find(params[:id])
    @postings.destroy
    redirect_to admin_postings_path
  end


end
