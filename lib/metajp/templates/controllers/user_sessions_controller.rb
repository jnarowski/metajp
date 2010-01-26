class UserSessionsController < ApplicationController
  layout 'application'
  
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:success] = "Login successful!"
      if @user_session.user.login_count == 1
        redirect_to :controller => :users, :action => :edit
      else
        redirect_to :controller => :dashboard
      end
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to :controller => :user_sessions, :action => :new
  end
end