require "rails_helper"

RSpec.describe Web::TasksController, type: :controller do
  describe "GET #index" do
    let(:tasks) { create_list(:task, 2) }

    before { get :index }

    it "populates array of all tasks" do
      expect(assigns(:tasks)).to match_array(tasks)
    end

    it "render index view" do
      expect(response).to render_template(:index)
    end
  end
end
