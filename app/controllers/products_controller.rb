class ProductsController < ApplicationController
  def index
    @product = Product.paginate(page: params[:page],
      per_page: Settings.product.per_page.size)
    flash[:danger] = t "product.not_load" unless @product
  end

  def show
    @product = Product.find_by(id: params[:id])
    return if @product
    flash[:danger] = t "product.dont_find"
    redirect_to root_url
  end
end
