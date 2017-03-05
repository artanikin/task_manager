class Web::Account::TasksController < Web::Account::ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]
  before_action :check_task_editable!, only: [:edit, :update, :destroy]

  def index
    if current_user.admin?
      @tasks = Task.all
    else
      @tasks = current_user.tasks
    end
  end

  def new
    @task = Task.new
    @task.build_attachment
  end

  def create
    @task = Task.new(filtered_params)

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

  def destroy
    @task.destroy
    redirect_to account_tasks_path, notice: "Task was successfully deleted"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :user_id, attachment_attributes: [:id, :file])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def check_task_editable!
    message = "You can't edit this task"
    redirect_to account_tasks_path, alert: message unless @task.editable?(current_user)
  end

  def filtered_params
    current_user.admin? ? task_params : task_params.merge(user_id: current_user.id)
  end
end
