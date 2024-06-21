# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
    before_action :authorize_request, only: [:create, :destroy]
    before_action :set_review, only: [:destroy]
  
    # POST /reviews
    def create
      @review = current_user.reviews.build(review_params)
      if @review.save
        render json: @review, status: :created
      else
        render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # GET /articles/:article_id/reviews
    def index
      @article = Article.find(params[:article_id])
      @reviews = @article.reviews
      render json: @reviews
    end
  
    # DELETE /reviews/:id
    def destroy
      if @review.user == current_user
        @review.destroy
        head :no_content
      else
        render json: { error: 'You can only delete your own reviews' }, status: :forbidden
      end
    end
  
    private
  
    def set_review
      @review = Review.find(params[:id])
    end
  
    def review_params
      params.require(:review).permit(:article_id, :rating, :comment)
    end
  end
  