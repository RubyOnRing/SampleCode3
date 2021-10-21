class ArticlesController < ApplicationController
  def index
    @articles = current_user.articles
  end

  def show
    @article = Article.find_by(id: params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      flash[:success] = "Article was created successfully."
      redirect_to articles_path
    else
      flash[:error] = @article.errors.full_messages
      render :new
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
