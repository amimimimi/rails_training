class MyThreadsController < ApplicationController

  def index
    @my_threads = MyThread.all.order(created_at: 'desc')
  end

  def new
    @my_thread = MyThread.new
  end

  def create
    @my_thread = MyThread.new(post_params)

    if @my_thread.save
      redirect_to my_threads_path
    else
      render 'new'
    end
  end

  def show
    @my_thread = MyThread.find(params[:id])
  end

  def edit
    @my_thread = MyThread.find(params[:id])
  end

  def update
    @my_thread = MyThread.find(params[:id])
    if @my_thread.update(post_params)
    else
    end
    redirect_to my_threads_path
  end

  def destroy
    @my_thread = MyThread.find(params[:id])
    if @my_thread.destroy
    end
    redirect_to my_threads_path
  end

  private
    def post_params
      params.require(:my_thread).permit(:title)
    end

end
