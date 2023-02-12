class Admin::HomesController < ApplicationController
  def top
    @customers = Customer.all
    
  end

  def about
  end
end
