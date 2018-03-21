require "rails_helper"
require "faker"

describe User, type: :model do
  context "create is valid" do
    it {is_expected.to have_many(:product_carts)}
    it {is_expected.to have_many(:orders)}
    it {is_expected.to have_many(:suggest_products)}
    it {is_expected.to have_many(:comments)}

    it {is_expected.to validate_presence_of(:firstname)}
    it {is_expected.to validate_presence_of(:lastname)}
    it {is_expected.to validate_presence_of(:email)}
    it {is_expected.to validate_presence_of(:password)}

    it {is_expected.to validate_length_of(:firstname).is_at_most(Settings.user.firstname.max_length)}
    it {is_expected.to validate_length_of(:lastname).is_at_most(Settings.user.lastname.max_length)}
    it {is_expected.to validate_length_of(:address1).is_at_most(Settings.user.address.max_length)}
    it {is_expected.to validate_length_of(:address2).is_at_most(Settings.user.address.max_length)}
    it {is_expected.to validate_length_of(:city).is_at_most(Settings.user.city.max_length)}
    it {is_expected.to validate_length_of(:sate).is_at_most(Settings.user.state.max_length)}
    it {is_expected.to validate_length_of(:country).is_at_most(Settings.user.country.max_length)}
    it {is_expected.to validate_length_of(:company).is_at_most(Settings.user.company.max_length)}
    it {is_expected.to validate_length_of(:phone).is_at_most(Settings.user.phone.max_length)
      .is_at_least(Settings.user.phone.min_length)}
    it {is_expected.to validate_length_of(:password).is_at_most(Settings.user.password.max_length)
      .is_at_least(Settings.user.password.min_length)}

    it {is_expected.to validate_numericality_of(:phone)}

    it {is_expected.to validate_uniqueness_of(:email)}
  end
end

describe User, "#downcase_email" do
  let(:user) {FactoryGirl.build(:user, email: "EMAIL@EMAIL.COM")}
  let(:email_is_number) {user.email = 123}

  it "should be downcase email" do
    expect(user.downcase_email).to eq("email@email.com")
  end

  it "should be string" do
    expect(email_is_number).to be_kind_of(String)
  end
end
