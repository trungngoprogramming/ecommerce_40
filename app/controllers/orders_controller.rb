class OrdersController < ApplicationController
  before_action :load_product_cart_user, only: %i(load_address new)
  before_action :must_login, only: %i(new index)
  before_action :cart_present, only: %i(new load_address)

  include SessionsHelper
  include CartsHelper

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
    if @address.blank?
      flash[:danger] = t "order.address.not_save"
    else
      order_error?
    end
  end

  def order_error?
    @order = current_user.orders.create address_ship: @address,
    order_number: @product_cart_user.count, total_price: total_price_with_discount
    if @order.save
      add_order_detail
      redirect_to orders_url
      @address = nil
    else
      flash[:danger] = @order.errors[:address_ship]
      redirect_to request.referer
    end
  end

  def add_order_detail
    @product_cart_user.transaction do
      @product_cart_user.find_each do |item|
        load_item item
        item_present_add_order_detail item
        cart_destroy
      end
    end
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
