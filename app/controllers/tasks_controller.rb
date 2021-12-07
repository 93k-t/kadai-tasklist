class TasksController < ApplicationController
  # tasks#index
  def index
    @tasks = Task.all
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
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = "Task が正常に投稿されました"
      redirect_to @task
    else
      flash.now[:danger] = "Task が投稿されませんでした"
      render :new
    end
  end
  
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
    redirect_to tasks_url
  end
end

private

# Strong Parameter
def task_params
  params.require(:task).permit(:content)
end