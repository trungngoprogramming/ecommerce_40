class CartsController < ApplicationController
  before_action :load_product, only: :update
  before_action :load_cart, only: :destroy
  before_action :must_login, only: %i(update index)
  before_action :load_product_cart, only: :update
  before_action :load_product_cart_user, only: %i(update index)

  include SessionsHelper
  include CartsHelper

  def update
    if @item_of_cart.present?
      quantity = @item_of_cart.quantity + Settings.cart.product.quantity
      update_quantity quantity
      update_total_price total_money_must_pay
    else
      insert_item Settings.cart.product.quantity, total_money_must_pay
    end
    redirect_to carts_url
  end

  def destroy
    @cart.destroy
    return redirect_to request.referer if @cart
    flash[:danger] = t "cart.not_destroy_item"
  end

  def index; end

  private

  def must_login
    return if logged_in?
    flash[:danger] = t "product.first_login"
    redirect_to login_url
  end

  def update_quantity quantity
    return if @item_of_cart.update_attributes(quantity: quantity)
    flash.now[:danger] = t "cart.not_update"
  end

  def update_total_price total_price
    return if @item_of_cart.update_attributes(total_price: total_price)
    flash[:danger] = t "cart.not_update_total_price"
  end

  def insert_item quantity, total_price
    @item = Cart.create(product_name: @product.name, price: @product.price,
      quantity: quantity, discount: @product.discount_customer_available, total_price: total_price)
    if @item.save
      @product_cart = current_user.product_carts.create(product_id: @product.id,
        cart_id: @item.id)
      return if @product_cart
      flash[:danger] = t "product_cart.not_save"
    else
      flash.now[:danger] = t "product.not_add_to_cart"
    end
  end

  def load_product
    @product = Product.find_by(id: params[:id])
    return if @product
    flash[:danger] = t "product.dont_find"
    redirect_to products_url
  end

  def load_cart
    @cart = Cart.find_by(id: params[:id])
    return if @cart
    flash[:danger] = t "cart.not_find_item"
  end

  def load_product_cart
    @product_item = current_user.product_carts.find_by(product_id: @product.id)
    return if @product_item.nil?
    @item_of_cart = Cart.find_by(id: @product_item.cart_id)
  end
end
