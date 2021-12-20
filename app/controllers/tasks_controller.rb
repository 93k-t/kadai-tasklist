class TasksController < ApplicationController
  # 下記コードでこの中の全アクションがログイン必須
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  # tasks#index
  def index
    if logged_in?
      @task = current_user.tasks.build
      @pagy, @tasks = pagy(current_user.tasks.order(id: :desc))
      @tasks = Task.all
    end
  end
  
  # tasks#show
  def show
    @task = Task.find(params[:id])
  end
  
  # tasks#new
  def new
    @task = Task.new
  end
  
  # task#create
  def create
    @task = current_user.tasks.build(task_params)
      if @task.save
        flash[:success] = "メッセージを投稿しました。"
        redirect_to root_url
      else
        @pagy, @tasks = pagy(current_user.tasks.order(id: :desc))
        flash.now[:danger] = "メッセージの投稿に失敗しました。"
        render "tasks/index"
      end
  end
    # @task = Task.new(task_params)
    
    # if @task.save
    #   flash[:success] = "Task が正常に投稿されました"
    #   redirect_to @task
    # else
    #   flash.now[:danger] = "Task が投稿されませんでした"
    #   render :new
    # end
  
  # tasks#edit
  def edit
    @task = Task.find(params[:id])
  end
  
  # tasks#update
  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = "Task は正常に更新されました"
      redirect_to @task
    else
      flash.now[:danger] = "Task は更新されませんでした"
      render :edit
    end
  end
  
  # task#destroy
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = "Task は正常に削除されました"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task =current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end