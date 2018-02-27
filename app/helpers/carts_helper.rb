module CartsHelper
  def product_of_user?
    return true if @product_cart_user
  end

  def total_price
    total_pay = Settings.cart.total_price.no_price
    @product_cart_user.each do |p|
      total_pay += Cart.find_by(id: p.cart_id).total_price
    end
    total_pay
  end

  def load_product_cart_user
    @product_cart_user = current_user.product_carts
    return if @product_cart_user
    must_login
  end

  def find_cart_product item
    Cart.find_by(id: item.cart_id)
  end

  def total_money_must_pay
    if @item_of_cart.nil?
      total_pay_item_nil
    else
      total_pay_item_present
    end
  end

  def total_pay_item_nil
    total_price = @product.price * Settings.cart.product.quantity
    discount_price = total_price * @product.discount_customer_available /
                     Settings.cart.discount.percent
    _total_pay = total_price - discount_price
  end

  def total_pay_item_present
    total_price = @item_of_cart.price * @item_of_cart.quantity
    discount_price = total_price * @item_of_cart.discount / Settings.cart.discount.percent
    _total_pay = total_price - discount_price
  end
end
