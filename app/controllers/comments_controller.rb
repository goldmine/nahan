# coding: utf-8

class CommentsController < ApplicationController
  def index
    @article = Article.find_by_id(params[:article_id])
    @comments = Array.new
    for i in @article.comments do
      @comments << i if i.is_childless?
    end
  end

  def new
    @comment = Comment.find_by_id(params[:comment_id])
    @child = @comment.children.new
  end

  def reply
    @comment = Comment.find_by_id(params[:id])
    @child = @comment.children.new(params[:comment])
    @child.article = @comment.article
    if current_user
      @child.user = current_user
         if @child.save
           redirect_to @comment.article, :notice => "Successfully    created comment."
         else
           redirect_to @comment.article, :notice => "failed created    comment."
         end
    else
      user = User.authenticate(params[:email], params[:password])
       if user
         set_current_user(user)
         @child.user = user
           if @child.save
             redirect_to @comment.article, :notice => "Successfully created comment."
           else
             redirect_to @comment.article, :notice => "failed created comment."
           end
       else
        redirect_to @comment.article, :notice => "邮箱地址或密码错！"
       end
    end

  end

  def create
    @article = Article.find_by_id(params[:article_id])
    @comment = Comment.new(:body => params[:body])
    @comment.article = @article
    if current_user
       @comment.user = current_user
       if @comment.save
         redirect_to @article, :notice => "Successfully created comment."
       else
         redirect_to @article, :notice => "failed created comment."
       end
    else
       user = User.authenticate(params[:email], params[:password])
       if user
         set_current_user(user)
         @comment.user = user
           if @comment.save
             redirect_to @article, :notice => "Successfully created comment."
           else
             redirect_to @article, :notice => "failed created comment."
           end
       else
        redirect_to @article, :notice => "邮箱地址或密码错！"
       end
    end
  end


  def show
    
  end

  def ding
    @comment = Comment.find_by_id(params[:comment_id])
    @comment.ding_count +=1
    if @comment.save
      redirect_to @comment.article
    end
  end


  protected
  def allow_to
    super :user, :all => true
    super :non_user, :all => true
  end

end
