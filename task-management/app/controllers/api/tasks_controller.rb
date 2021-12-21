class Api::TasksController < ApplicationController
  protect_from_forgery
  # skip_before_action :verify_authenticity_token

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

  # PATCH/PUT /tasks/task_id
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      render :show, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DESTROY /tasks/task_id
  def destroy
    @task = Task.find(params[:id])
    if @task.destroy!
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