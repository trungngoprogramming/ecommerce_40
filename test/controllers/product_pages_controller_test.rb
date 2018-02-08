require "test_helper"

class ProductPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get product_pages_new_url
    assert_response :success
  end
end
