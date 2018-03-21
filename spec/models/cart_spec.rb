require "rails_helper"

describe Cart do
  describe "should pass validdates" do
    it {is_expected.to have_many(:product_carts)}
  end

  describe "#total_price" do
    let(:cart) {FactoryGirl.create :cart}
    it "should show total price" do
      expect(cart.total_price).to eq(400)
    end
  end
end
