# app/controllers/carts_controller.rb
class CartsController < ApplicationController
    before_action :set_cart, only: [:show, :add_item, :remove_item]
    before_action :authorize_request, only: [:show, :add_item, :remove_item]
  
    # GET /cart
    def show
      render json: @cart, include: :cart_items
    end
  
    # POST /cart/add_item
    def add_item
      article = Article.find(params[:article_id])
      item = @cart.cart_items.find_or_initialize_by(article: article)
      item.quantity += params[:quantity].to_i
      item.save
  
      render json: @cart, include: :cart_items
    end
  
    # DELETE /cart/remove_item/:id
    def remove_item
      item = @cart.cart_items.find(params[:id])
      item.destroy
  
      render json: @cart, include: :cart_items
    end
  
    private
  
    def set_cart
      @cart = current_user.cart || current_user.create_cart
    end
  end
  