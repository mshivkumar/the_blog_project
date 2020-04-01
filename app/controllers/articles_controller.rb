class ArticlesController < ApplicationController

  before_action :set_article, only: %i[show edit update destroy]
  # before_action :set_article, only: [:show, :edit, :update, :destroy]
  def index
    @articles = Article.all
  end

  def show;
  end

  def new
    @article = Article.new
  end

  def edit;
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:success] = 'Article successfully created'
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def destroy
    @article.destroy
    flash[:destroy] = "Article successfully deleted"
    redirect_to articles_path
  end

  def update
    @article.user = User.first
    if @article.update(article_params)
      flash[:info] = 'Article successfully updated'
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
