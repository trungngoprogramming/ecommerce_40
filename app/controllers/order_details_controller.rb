class OrderDetailsController < ApplicationController
  before_action :load_order, only: %i(show destroy update)
  before_action :stocking?, only: :update

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

  def stocking?
    item_name = Settings.product.name.empty
    @load_order.order_details.each do |detail|
      next unless detail.product.quantity_product_available == Settings.quantity.product.not_available
      item_name += ", #{detail.product.name}"
      detail.destroy
    end
    update_when_out_of_stock
    item_name_blank item_name
    destroy_order
  end

  def update_when_out_of_stock
    return if @load_order.update_attributes order_number: @load_order.order_details.count, total_price:
      @load_order.order_details.sum(:total_price)
    flash[:danger] = t "order_detail.not_update"
  end

  def item_name_blank item_name
    return if item_name.blank?
    flash[:danger] = "#{t 'product.out_of_stock'} #{item_name}"
  end

  def destroy_order
    return unless @load_order.order_number.zero?
    flash[:danger] = t "order.not_destroy" unless @load_order.destroy
    redirect_to orders_url
  end

  def product_quantity
    @load_order.order_details.each do |item|
      item.product.update_attributes quantity_product_available:
        item.product.quantity_product_available - item.quantity
    end
  end

  def load_order
    if current_user
      @load_order = current_user.orders.find_by id: params[:id]
      return if @load_order
      flash.now[:danger] = t "order.not_find"
    else
      must_login
    end
  end

  def must_login
    return if logged_in?
    flash[:danger] = t "product.first_login"
    redirect_to login_url
  end
end
