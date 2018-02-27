module OrdersHelper
  def status f
    t "order.status.#{f.status}"
  end
end
