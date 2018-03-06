module OrdersHelper
  def status status
    t "order.status.#{status}"
  end

  def load_user order
    user = User.find_by id: order.user_id
    flash[:danger] = t "admin.order.not_load_user" unless user
    user
  end
end
