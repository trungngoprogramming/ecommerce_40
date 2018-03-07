class CartItemsController < ApplicationController
  before_action :load_card_item, only: %i(minus plus)
  after_action :update_total_price_item, only: %i(minus plus)
  before_action :stocking?, only: %i(minus plus)

  include SessionsHelper
  include CartsHelper
  include OrdersHelper

  def minus
    if @item_of_cart.quantity == Settings.cart.item.than_one
      flash[:danger] = t("cart.item_more")
    else
      update_decrease_quantity
    end
    respond_to do |format|
      format.js{redirect_to request.referer}
    end
  end

  def plus
    if @item_of_cart.update_attributes quantity:
      @item_of_cart.quantity + Settings.quantity.increase.number
    else
      flash[:danger] = t "cart.not_update_quantity"
    end
    respond_to do |format|
      format.js{redirect_to request.referer}
    end
  end

  private

  def update_decrease_quantity
    return if @item_of_cart.update_attributes quantity:
      @item_of_cart.quantity - Settings.quantity.increase.number
    flash[:danger] = t "cart.not_update_quantity"
  end

  def update_total_price_item
    return if @item_of_cart.update_attributes total_price: total_pay_item_present
    flash[:danger] = t "cart.not_update_total_price"
  end

  def load_card_item
    @item_of_cart = Cart.find_by id: params[:cart_id]
    return if @item_of_cart
    flash.now[:danger] = t "cart.not_find_item"
  end
end
