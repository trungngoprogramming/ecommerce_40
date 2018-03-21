require "rails_helper"

describe "products/show" do
  let(:product) {FactoryGirl.create :product}
  it "should show products" do
    assign(:product, product)
    render
    expect(rendered).to match product.image
    expect(rendered).to match product.name
    expect(rendered).to match product.price
    expect(rendered).to match product.size
    expect(rendered).to match product.description
    expect(rendered).to match product.discount
    expect(rendered).to match product.color
    expect(rendered).to match product.rate
  end
end
