class Public::GreatsController < ApplicationController
  @greats = current_customer.greats
end
