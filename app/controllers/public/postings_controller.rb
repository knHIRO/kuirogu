class Public::PostingsController < ApplicationController
  def new
    @posting = Posting.new
  end

  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
     @posting = Posting.new(posting_params)

     @posting.customer_id = current_customer.id
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if  @posting.save
    # 4. トップ画面へリダイレクト

    redirect_to public_posting_path(@posting.id)
    else
     @postings = Posting.all
    render :new
    end
  end

  def destroy
    @posting = Posting.find(params[:id])
    @posting.destroy
    redirect_to public_customer_path(@posting.customer_id)
  end

  def show
    @posting = Posting.find(params[:id])
    @post_comment = PostComment.new
  end



  def search
    @section_title = "「#{params[:search]}」の検索結果"
    @postings = if params[:search].present?
           Posting.where(["body LIKE ?", "%#{params[:search]}%"]).page(params[:page]) #.per(12).recent
         else
           Posting.none
         end

  end




  private
  def posting_params
    params.require(:posting).permit(:customer_id, :body, :is_active, :profile_image, :lat, :lng)
  end
end

