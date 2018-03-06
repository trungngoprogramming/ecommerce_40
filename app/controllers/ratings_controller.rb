class RatingsController < ApplicationController
  before_action :must_login, only: %i(rate_create rate_update)

  include SessionsHelper

  def rate_create
    @create_rate = Rating.create(rating: params[:star], user_id: current_user.id, product_id: params[:id])
    flash[:danger] = t "product.not_rate" unless @create_rate
    respond_to do |format|
      format.js
    end
  end

  def rate_update
    @product_rate = current_user.ratings.find_by(product_id: params[:id])
    @update_rate = @product_rate.update_attributes(rating: params[:star])
    flash[:danger] = t "product.not_rate" unless @update_rate
    respond_to do |format|
      format.js
    end
  end

  private

  def must_login
    return if logged_in?
    flash[:danger] = t "product.first_login"
    redirect_to login_url
  end
end
