class Web::Account::TasksController < Web::Account::ApplicationController
  before_action :set_task, only: [:edit, :update]
  before_action :check_task_editable!, only: [:edit, :update]

  def index
    @tasks = current_user.tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params.merge(user_id: current_user.id))

    if @task.save
      redirect_to account_tasks_path, notice: "Task was successfully created"
    else
      flash[:alert] = "Task not created"
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to account_tasks_path, notice: "Task was successfully updated"
    else
      flash[:alert] = "Task not updated"
      render :edit
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def check_task_editable!
    message = "You can`t edit this task"
    redirect_to account_tasks_path, alert: message if @task.assigned?(current_user)
  end
end
