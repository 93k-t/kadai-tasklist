class TasksController < ApplicationController
  # 下記コードでこの中の全アクションがログイン必須
  before_action :require_user_logged_in
  # correct_user 現時点ではdestroyのみが定義されている状態,ここに詳細,編集,更新を追加
  before_action :correct_user, only: [:destroy, :show, :edit, :update]
  
  # tasks#index
  def index
      @pagy, @tasks = pagy(current_user.tasks.order(id: :desc))
  end
  
  # tasks#show
  def show
  end
  
  # tasks#new
  def new
    @task = current_user.tasks.build
  end
  
  # task#create
  def create
    @task = current_user.tasks.build(task_params)
      if @task.save
        flash[:success] = "Task を投稿しました。"
        redirect_to root_url
      else
        @pagy, @tasks = pagy(current_user.tasks.order(id: :desc))
        flash.now[:danger] = "Task の投稿に失敗しました。"
        render "tasks/new"
      end
  end
    
  # tasks#edit
  def edit
  end
  
  # tasks#update
  def update
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
    @task.destroy
    
    flash[:success] = "Task は正常に削除されました"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status, :user)
  end
  
  # ログインユーザーのみがCRUD操作を行えるようになるメソッド
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end