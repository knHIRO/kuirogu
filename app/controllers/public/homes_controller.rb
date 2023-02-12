class Public::HomesController < ApplicationController
  def top
    @postings = Posting.all
    #@customer = Customer.find(params[:id])
  end
end
