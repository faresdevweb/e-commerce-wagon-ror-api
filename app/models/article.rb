class Article < ApplicationRecord
    before_action :authorize_request, only: [:create, :update, :destroy]
    before_action :set_article, only: [:show]

    # GET /articles
    def index
      @articles = Article.all
      render json: @articles
    end

    # GET /articles/:id
    def show
      render json: @article
    end

    private

    def set_article
      @article = Article.find(params[:id])
    end
end
