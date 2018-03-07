class OrdersController < ApplicationController
  before_action :load_product_cart_user, only: %i(load_address new)
  before_action :must_login, only: %i(new index)
  before_action :cart_present, only: %i(new load_address)
  before_action :stocking?, only: :new

  include SessionsHelper
  include CartsHelper
  include OrdersHelper

  def index; end

  def new; end

  def load_address
    @address = params[:address]
    if @address.present?
      address_present
    else
      flash[:danger] = t "order.address.not_send"
      redirect_to request.referer
    end
  end

  private

  def cart_present
    return if @product_cart_user.present?
    flash[:danger] = t "order.cart.not_item"
    redirect_to carts_url
  end

  def address_present
    if current_user.orders.create address_ship: @address,
      order_number: @product_cart_user.count, total_price: total_price_with_discount
      add_order_detail
    else
      flash[:danger] = t "order.address.not_save"
    end
  end

  def add_order_detail
    @product_cart_user.each do |item|
      load_item item
      item_present_add_order_detail item
      cart_destroy
    end
    redirect_to orders_url
    @address = nil
  end

  def item_present_add_order_detail f
    flash[:danger] = t "order.not_order_item" unless OrderDetail.create quantity:
      @item.quantity,
      discount: @item.discount, total_price: @item.total_price,
      order_id: current_user.orders.ids.last,
      product_id: f.product_id
  end

  def cart_destroy
    flash[:danger] = t "not_remove_cart" unless @item.destroy
  end

  def load_item f
    @item = Cart.find_by id: f.cart_id
    flash[:danger] = t "cart.not_find_item" unless @item
  end

  def must_login
    return if logged_in?
    flash[:danger] = t "product.first_login"
    redirect_to login_url
  end
end
