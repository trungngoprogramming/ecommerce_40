class SessionsController < ApplicationController
  before_action :load_user, only: :create

  include SessionsHelper

  def new; end

  def create
    if @user.authenticate(params[:session][:password])
      log_in @user
      flash[:success] = t "user.welcome"
      redirect_to root_url
    else
      flash.now[:danger] = t "user.password.invalid"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url
  end

  private

  def load_user
    @user = User.find_by(email: params[:session][:email].downcase)
    return if @user
    render :new
  end
end
