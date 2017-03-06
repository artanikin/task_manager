class Web::TasksController < Web::ApplicationController
  def index
    respond_with(@tasks = Task.includes(:user).order("created_at DESC").decorate)
  end
end
