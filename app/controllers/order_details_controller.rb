class OrderDetailsController < ApplicationController
  before_action :load_order, only: :show

  include SessionsHelper

  def show; end

  private

  def load_order
    @load_order = current_user.orders.find_by id: params[:id]
    return if @load_order
    flash.now[:danger] = t "order.not_find"
  end
end
