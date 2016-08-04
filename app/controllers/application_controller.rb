class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :disallow_user, :require_user

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
    @current_user
  end

  def require_user
    unless current_user
      respond_to do |format|
        format.html { redirect_to :back , notice: 'You need to be logged in to do that.'}
      end
    end
  end


  def disallow_user
    if current_user
      respond_to do |format|
        format.html { redirect_to :root , notice: 'You are already logged in.' }
      end
    end
  end


end
