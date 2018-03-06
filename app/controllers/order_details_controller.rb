class OrderDetailsController < ApplicationController
  before_action :load_order, only: %i(show destroy update)

  include SessionsHelper

  def show; end

  def update
    return redirect_to orders_url if @load_order.update_attributes status:
      Settings.order.status.considered
    flash[:danger] = t "order_detail.not_update"
  end

  def destroy
    flash[:danger] = t "order_detail.not_destroy" unless @load_order.destroy
    redirect_to orders_url
  end

  private

  def load_order
    @load_order = current_user.orders.find_by id: params[:id]
    return if @load_order
    flash.now[:danger] = t "order.not_find"
  end
end
