class Web::TasksController < Web::ApplicationController
  def index
    respond_with(@tasks = Task.all.order("created_at DESC").decorate)
  end
end
