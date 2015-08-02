
class SessionsController < ApplicationController

  def new
      @tweet = Tweet.new
      @users = User.all
      @tweets = Tweet.all
                    .order("created_at desc")
                    .page(1)
                    .per(5)
  end

  def create
    @tweets = Tweet.all

    username = params[:username]
    password = params[:password]

    user = User.find_by username: username
    if (user) && (user.authenticate password)
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:danger] = "Try again. Invalid email/password combination"
      render :new
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

end
