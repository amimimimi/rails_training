class MyThreads::CommentsController < ApplicationController

  def index
    @my_thread = MyThread.find(params[:my_thread_id])
  end

  def new
    @my_thread = MyThread.find(params[:my_thread_id])
    @comment = Comment.new
  end

  def create
    @my_thread = MyThread.find(params[:my_thread_id])
    @my_thread.comments.create(comment_param)
    redirect_to my_thread_comments_path(@my_thread)
  end

  def edit
    @my_thread = MyThread.find(params[:my_thread_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_param)
    redirect_to my_thread_comments_path(@comment.my_thread)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to my_thread_comments_path(@comment.my_thread)
  end

  private
    def comment_param
      params.require(:comment).permit(:body)
    end

end
