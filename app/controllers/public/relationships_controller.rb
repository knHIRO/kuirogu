class Public::RelationshipsController < ApplicationController
  # フォローするとき
  def create
    current_customer.follow(params[:customer_id])
    @customer = Customer.find(params[:customer_id])
    @customer.create_notification_follow!(current_customer)
    redirect_to request.referer
  end
  # フォロー外すとき
  def destroy
    current_customer.unfollow(params[:customer_id])
    redirect_to request.referer
  end
  # フォロー一覧
  def followings
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings
  end
  # フォロワー一覧
  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers
  end

  before_action :ensure_normal_user, only: %i[update destroy]

  def ensure_normal_customer
    if resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの更新・削除はできません。'
    end
  end

end
