class ArticlesController < ApplicationController
  def index
    @articles = Article.all
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
    @article = current_user.articles.find(params[:id])
  end

  def update
    @article = current_user.articles.find(params[:id])
    if @article.update(article_params)
      redirect_to articles_path
      flash[:notice] = "Article updated!"
    else
      render "edit"
      flash.now[:alert] = @article.errors.full_messages.join("\n")
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :is_published, :publish_date, :content)
  end
end
