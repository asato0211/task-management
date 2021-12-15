class Api::TasksController < ApplicationController
  protect_from_forgery  # 後でトークン認証を実装する

  # GET /tasks
  def index
    # 更新順で返す
    @tasks = Task.order('updated_at DESC')
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      render :show, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      render :show, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

    private

    def task_params
      params.fetch(:task, {}).permit(
          :title, :done
      )
    end
end