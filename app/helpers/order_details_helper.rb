module OrderDetailsHelper
  def order_present
    return true if @load_order
  end
end
