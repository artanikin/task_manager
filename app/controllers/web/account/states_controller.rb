class Web::Account::StatesController < Web::Account::ApplicationController
  before_action :set_task

  def update
    respond_with(@task.change_state(current_user, params[:id]), location: -> { account_tasks_path })
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end
end
