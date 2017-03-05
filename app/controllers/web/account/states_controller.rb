class Web::Account::StatesController < Web::Account::ApplicationController
  def update
    @task = Task.find(params[:task_id])

    if @task.editable?(current_user) && @task.send("can_#{params[:id]}?")
      @task.send(params[:id])
      flash[:notice] = "State successfully changed"
    else
      flash[:alert] = "You can't change task for this state"
    end

    redirect_to account_tasks_path
  end
end
