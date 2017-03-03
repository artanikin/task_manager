class Web::Account::TasksController < Web::Account::ApplicationController
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

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
