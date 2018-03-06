module ProductsHelper
  def product_unit attribute, unit
    "#{attribute}#{unit}"
  end

  def rating_star star
    session[:star] = star
  end

  def load_rating product
    return unless current_user
    current_user.ratings.find_by(product_id: product.id)
  end
end
