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

    unless @current_user.nil?
      followers_id = @current_user.following_users.pluck(:id)
      tweets_ids = followers_id << @current_user.id
    end

    @tweets = Tweet.where(user_id: tweets_ids).order("created_at desc").page(params[:page]).per(5)
    @users = User.all
                .reject{|user| @current_user.following? user}
                .reject{|user| @current_user == user}
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

  def follow
    user = User.find(params[:id])
    @current_user.follow(user)
    redirect_to root_path, notice: "You are now following " "#{user.username}"
  end


  def unfollow
      user = User.find(params[:id])
      @current_user.stop_following(user)
      redirect_to root_path, notice: "You just unfollowed " "#{user.username}"
  end


  def delete
    @tweet = Tweet.find params[:id]
    @tweet.destroy
    redirect_to root_path
  end

end
