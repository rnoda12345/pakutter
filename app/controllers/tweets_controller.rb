class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :update, :destroy]

  def index
  	@tweets = Tweet.all
  end

  def confirm
    @tweet = Tweet.new(tweets_params)
    render :new if @tweet.invalid?
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweets_params)
      # 一覧画面へ遷移して"つぶやきを編集しました！"とメッセージを表示します。
  	  redirect_to tweets_path, notice: "つぶやきを編集しました！"
    else
      # 編集フォームを再描画します。
      render 'edit'
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
  	          redirect_to tweets_path, notice: "つぶやきを削除しました！"
  end

  def new
    if params[:back]
      @tweet = Tweet.new(tweets_params)
    else
      @tweet = Tweet.new
    end  
  end

  def create
    @tweet = Tweet.new(tweets_params)
    if @tweet.save
      # 一覧画面へ遷移して"つぶやきを作成しました！"とメッセージを表示します。
      redirect_to tweets_path, notice: "つぶやきを作成しました！"
    else
      # 入力フォームを再描画します。
      render 'new'
  	end
  end
	  
  private
    def tweets_params
      params.require(:tweet).permit(:content)
    end
      # idをキーとして値を取得するメソッド
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end
  
end
