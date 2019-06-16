class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :check_logged_in, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @articles = Article.search(params[:q]).paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.author_id = current_user.id
    if @article.save
      redirect_to articles_path
      flash[:notice] = "Article created!"
    else
      flash.now[:alert] = @article.errors.full_messages.join("\n")
      render "new"
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to articles_path
      flash[:notice] = "Article updated!"
    else
      render "edit"
      flash.now[:alert] = @article.errors.full_messages.join("\n")
    end
  end

  def destroy
    flash[:notice] = "Article deleted!" if @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = current_user.articles.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :is_published, :publish_date, :content)
  end

  def check_logged_in
    redirect_to new_session_path unless current_user
  end
end
