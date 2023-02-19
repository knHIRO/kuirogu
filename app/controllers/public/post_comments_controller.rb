class Public::PostCommentsController < ApplicationController
   def create
    posting = Posting.find(params[:posting_id])
    comment = current_customer.post_comments.new(post_comment_params)
    comment.posting_id = posting.id
    comment.save
    @posting.create_notification_post_comment!(current_customer, @post_comment.id)
    redirect_to public_posting_path(posting)
   end

   def destroy
    PostComment.find(params[:id]).destroy
    redirect_to public_posting_path(params[:posting_id])
   end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
