module OrderDetailsHelper
  def load_product_name f
    f.product.name
  end

  def order_present
    return true if @load_order
  end
end
