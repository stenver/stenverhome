class ArticlesController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.create(article_params)
    if @article.save
      flash[:success] = "Article successfully created."
      redirect_to @article
    else
      render :new
    end
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
