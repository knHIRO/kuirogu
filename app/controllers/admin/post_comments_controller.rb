 class Admin::PostCommentsController < ApplicationController
#   def create
#     posting = Posting.find(params[:posting_id])
#     comment = current_customer.post_comments.new(post_comment_params)
#     comment.posting_id = posting.id
#     comment.save
#     redirect_to admin_posting_path(posting)
#   end

#   def destroy
#     PostComment.find(params[:id]).destroy
#     redirect_to admin_posting_path(params[:posting_id])
#   end

#   private

#   def post_comment_params
#     params.require(:post_comment).permit(:comment)
#   end

 end
