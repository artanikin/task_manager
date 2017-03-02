class Web::TasksController < Web::ApplicationController
  def index
    @tasks = Task.all.order("created_at DESC")
  end
end
