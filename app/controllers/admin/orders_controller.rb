module Admin
  class OrdersController < ApplicationController
    before_action :must_admin, only: :index
    before_action :load_order, only: :update
    include SessionsHelper

    def index
      @orders = Order.paginate(page: params[:page], per_page: Settings.order.per_page.size)
      flash.now[:danger] = t "order.not_load" unless @orders
    end

    def update
      return reload_admin_orders_page if @order.update_attributes status: Order.statuses[params[:status]]
      flash[:danger] = t "admin.order.status.not_update"
    end

    private

    def reload_admin_orders_page
      respond_to do |format|
        format.js{redirect_to admin_orders_url}
      end
    end

    def load_order
      @order = Order.find_by id: params[:id]
      flash[:danger] = t "admin.order.not_find" unless @order
    end

    def must_admin
      if logged_in? && current_user.role == "user"
        flash[:danger] = t "auth.not_admin"
        redirect_to root_url
      elsif logged_in?.blank?
        flash[:danger] = t "product.first_login"
        redirect_to login_url
      end
    end
  end
end
