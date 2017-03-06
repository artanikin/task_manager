class Web::Account::TasksController < Web::Account::ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :check_task_editable!, only: [:show, :edit, :update, :destroy]

  def index
    respond_with(@tasks = Task.for_user(current_user))
  end

  def show; end

  def new
    respond_with(@task = Task.new)
  end

  def create
    respond_with(@task = Task.create(filtered_params), location: -> { account_tasks_path })
  end

  def edit; end

  def update
    @task.update(task_params)
    respond_with(@task, location: -> { account_tasks_path })
  end

  def destroy
    respond_with(:account, @task.destroy)
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
