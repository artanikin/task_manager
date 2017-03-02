class Web::Account::TasksController < Web::Account::ApplicationController
  def index
    @tasks = current_user.tasks
  end
end
