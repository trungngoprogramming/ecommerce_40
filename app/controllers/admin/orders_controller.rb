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
      if params[:status] == "moving" && @order.update_attributes(status:
        Settings.order.status.moving)
        send_mail
      elsif params[:status] == "arrived" && @order.update_attributes(status:
        Settings.order.status.arrived)
        send_mail
      else
        flash[:danger] = t "admin.order.status.not_update"
      end
      reload_admin_orders_page
    end

    private

    def reload_admin_orders_page
      respond_to do |format|
        format.js{redirect_to admin_orders_url}
      end
    end

    def send_mail
      return if SentEmailJob.set(wait: Settings.admin.email.wait.seconds).perform_later(@order)
      flash[:danger] = t "admin.order.status.not_send_mail"
    end

    def load_order
      @order = Order.find_by(id: params[:id])
      flash[:danger] = t "admin.order.not_find" unless @order
    end

    def must_admin
      if logged_in? && current_user.role != Settings.auth.admin.role
        flash[:danger] = t "auth.not_admin"
        redirect_to root_url
      elsif logged_in?.blank?
        flash[:danger] = t "product.first_login"
        redirect_to login_url
      end
    end
  end
end
