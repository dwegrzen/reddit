class UserSessionsController < ApplicationController

  before_action :disallow_user, only: [:new, :create]


  def new
  end

  def create
    @user = User.find_by(username: params[:loginuser][:username])
    if @user
      if @user.authenticate(params[:loginuser][:password])
        session[:user_id] = @user.id
        redirect_to :root
      else
        render :new
      end
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

  private

  def disallow_user
    if current_user
      respond_to do |format|
        format.html { redirect_to :root , notice: 'You are already logged in.' }
      end
    end
  end

end
