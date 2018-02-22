class User < ApplicationRecord
  has_many :carts, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :suggest_products, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_save{self.email = email.downcase}

  validates :firstname, presence: true, length:
    {maximum: Settings.user.firstname.max_length,
     too_long: I18n.t("user.firstname.too_long")}
  validates :lastname, presence: true, length:
    {maximum: Settings.user.lastname.max_length,
     too_long: I18n.t("user.lastname.too_long")}
  validates :address1, allow_nil: true, length:
    {maximum: Settings.user.address.max_length,
     too_long: I18n.t("user.address.too_long")}
  validates :address2, allow_nil: true, length:
    {maximum: Settings.user.address.max_length,
     too_long: I18n.t("user.address.too_long")}
  validates :city, allow_nil: true, length:
    {maximum: Settings.user.city.max_length,
     too_long: I18n.t("user.city.too_long")}
  validates :state, allow_nil: true, length:
    {maximum: Settings.user.state.max_length,
     too_long: I18n.t("user.state.too_long")}
  validates :country, allow_nil: true, length:
    {maximum: Settings.user.country.max_length,
     too_long: I18n.t("user.country.too_long")}
  validates :phone, presence: true, length:
    {minimum: Settings.user.phone.min_length,
     maximum: Settings.user.phone.max_length,
     too_long: I18n.t("user.phone.too_long"),
     too_short: I18n.t("user.phone.too_short")}
  validates :company, allow_nil: true, length:
    {maximum: Settings.user.company.max_length,
     too_long: I18n.t("user.company.too_long")}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true,
    format: {with: VALID_EMAIL_REGEX}
  has_secure_password
  validates :password, presence: true, length:
    {maximum: Settings.user.password.max_length,
     minimum: Settings.user.password.min_length,
     too_short: I18n.t("user.password.too_short"),
     too_long: I18n.t("user.password.too_long")}
end
