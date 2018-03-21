require "rails_helper"

describe CartsController, type: :controller do
  let(:cart) {FactoryGirl.create :cart}

  describe "before action" do
    context "cart must" do
      it {is_expected.to use_before_action(:load_product)}
      it {is_expected.to use_before_action(:load_cart)}
      it {is_expected.to use_before_action(:must_login)}
      it {is_expected.to use_before_action(:load_product_cart)}
      it {is_expected.to use_before_action(:load_product_cart_user)}
    end
  end

  describe "GET index" do
    it "show products when added to cart" do
      get :index
      expect(assigns(:carts)).to eq([cart])
    end
  end

  describe "PATCH update" do
    context "cart update" do
      it "change quantity when quantity increase or decrease" do
        patch :update, params: {id: cart.id, cart: {quantity: 1}}
        expect(cart.quantity).to eq(1)
      end

      it "should return quantity equal zero" do
        cart.quantity = -1
        expect(cart.quantity).to eq(0)
      end

      it "should quantity change" do
        cart.quantity = 1
        expect(cart.quantity).to eq(1)
      end
    end
  end

  describe "DELETE destroy" do
    it "shoud delete cart" do
      delete :destroy, params: {id: cart.id}
      expect(response).to be_destroyed
    end
  end
end
