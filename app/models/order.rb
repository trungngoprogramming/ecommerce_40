class Order < ApplicationRecord
  enum status: %i(considering considered moving arrived)

  belongs_to :user
  has_many :order_details, dependent: :destroy

  validates :address_ship, presence: true, length:
    {maximum: Settings.user.address.max_length,
     too_long: I18n.t("user.address.too_long")}
end
