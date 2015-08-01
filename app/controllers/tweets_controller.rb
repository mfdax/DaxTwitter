class TweetsController < ApplicationController

  before_action do
    @tweets = Tweet.all
                   .order("created_at desc")
                   .page(params[:page])

    @current_user = User.find_by id: session[:user_id]
      if @current_user.nil?
        redirect_to login_path
      end
    end

  def index
  end


  def new
    @tweet = Tweet.new
  end


  def dashboard
    @tweet = Tweet.new
    @users = User.all
  end


  def create
  @tweet = Tweet.new params.require(:tweet).permit (:content)
  @tweet.user_id = @current_user.id
    if @tweet.save
      redirect_to root_path
    else
      render :new
    end
  end


  def delete
    @tweet = Tweet.find params[:id]
    @tweet.destroy
    redirect_to root_path
  end

end
