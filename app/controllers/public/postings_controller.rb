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
    #flash[:notice]="You have created book successfully."

    redirect_to public_posting_path(@posting.id)
    else
     @postings = Posting.all
    #@user = current_user
    render :new
    end
  end

  def show
    #@item = Item.new
    @posting = Posting.find(params[:id])
  end



  private

  def posting_params
    params.require(:posting).permit(:customer_id, :body, :is_active, :profile_image)
  end
end

