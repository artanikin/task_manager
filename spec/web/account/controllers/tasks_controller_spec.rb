require "rails_helper"

RSpec.describe Web::Account::TasksController, type: :controller do
  describe "GET #index" do
    let!(:user) { create(:user) }
    let!(:my_tasks) { create_list(:task, 2, user: user) }
    let!(:another_task) { create(:task) }

    subject { get :index }

    context "authenticated user" do
      before do
        session[:user_id] = user.id
        subject
      end

      it "populates array of all tasks" do
        expect(assigns(:tasks)).to match_array(my_tasks)
      end

      it "render index view" do
        expect(response).to render_template(:index)
      end
    end

    context "not authenticated user" do
      it "redirect_to sign in page" do
        subject
        expect(response).to redirect_to(new_users_session_path)
      end
    end
  end
end
