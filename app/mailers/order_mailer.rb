class OrderMailer < ApplicationMailer
  def status order
    @order = order
    mail to: order.user.email, subject: t("admin.order.mail.subject")
  end
end
