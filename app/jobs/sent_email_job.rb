class SentEmailJob < ApplicationJob
  queue_as :default

  def perform order
    OrderMailer.status(order).deliver_later
  end
end
