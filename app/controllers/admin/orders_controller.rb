module Admin
  class OrdersController < ApplicationController
    before_action :must_admin, only: :index
    before_action :load_order, only: %i(status_moving status_arrived)
    include SessionsHelper

    def index
      @order_all = Order.paginate(page: params[:page], per_page: Settings.order.per_page.size)
      flash.now[:danger] = t "order.not_load" unless @order_all
    end

    def status_moving
      if @order.update_attributes status: Settings.order.status.moving
        send_mail
        respond_to do |format|
          format.js{redirect_to admin_orders_url}
        end
      else
        flash[:danger] = t "admin.order.status.not_update"
      end
    end

    def status_arrived
      if @order.update_attributes status: Settings.order.status.arrived
        send_mail
        respond_to do |format|
          format.js{redirect_to admin_orders_url}
        end
      else
        flash[:danger] = t "admin.order.status.not_update"
      end
    end

    private

    def send_mail
      return if SentEmailJob.set(wait: Settings.admin.email.wait.seconds).perform_later(@order)
      flash[:danger] = t "admin.order.status.not_send_mail"
    end

    def load_order
      @order = Order.find_by(id: params[:id])
      flash[:danger] = t "admin.order.not_find" unless @order
    end

    def must_admin
      if logged_in?
        unless current_user.role == Settings.auth.admin.role
          flash[:danger] = t "auth.not_admin"
          redirect_to root_url
        end
      else
        flash[:danger] = t "product.first_login"
        redirect_to login_url
      end
    end
  end
end
