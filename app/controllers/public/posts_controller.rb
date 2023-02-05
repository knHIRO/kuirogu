class Public::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end
end
