class ArticlesController < ApplicationController

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments
  end

  def new
  end

  def create
  end

  def destroy
  end

  def edit
  end

  def update
  end
end
