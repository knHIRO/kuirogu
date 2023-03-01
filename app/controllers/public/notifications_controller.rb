class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_customer.passive_notifications.all.page(params[:page])
    @notifications.where(checked: false).each do |notification|
    notification.update_attribute(:checked, true)
    end
  end
end
