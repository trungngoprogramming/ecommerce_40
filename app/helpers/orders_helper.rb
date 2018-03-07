module OrdersHelper
  def status status
    t "order.status.#{status}"
  end

  def load_user order
    user = User.find_by id: order.user_id
    flash[:danger] = t "admin.order.not_load_user" unless user
    user
  end

  def stocking?
    item_name = Settings.product.name.empty
    current_user.product_carts.each do |item|
      product = Product.find_by id: item.product_id
      if product.quantity_product_available == Settings.quantity.product.not_available
        item_name += ", #{item.product.name}"
        item.destroy
      end
    end
    item_name_blank item_name
  end

  def item_name_blank item_name
    return if item_name.blank?
    flash[:danger] = "#{t 'product.out_of_stock'} #{item_name}"
    redirect_to carts_url
  end
end
