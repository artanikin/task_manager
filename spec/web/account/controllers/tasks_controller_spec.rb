require "rails_helper"

RSpec.describe Web::Account::TasksController, type: :controller do
  describe "GET #index" do
    let(:my_tasks) { create_list(:task, 2, user: user) }
    let(:another_task) { create(:task) }

    subject { get :index }

    context "authenticated user" do
      sign_in_user

      before { subject }

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

  describe "GET #new" do
    subject { get :new }

    context "authenticated user" do
      sign_in_user

      before { subject }

      it "assigns new Task to @task" do
        expect(assigns(:task)).to be_a_new(Task)
      end

      it "render view new" do
        expect(response).to render_template(:new)
      end
    end

    context "not authenticated user" do
      it "redirect_to sign in page" do
        subject
        expect(response).to redirect_to(new_users_session_path)
      end
    end
  end

  describe "POST #create" do
    let(:parameters) { { task: attributes_for(:task) } }

    subject { post :create, params: parameters }

    context "authenticated user" do
      sign_in_user

      it "create new task for user" do
        expect{ subject }.to change(user.tasks, :count).by(1)
      end

      it "redirect to user tasks list" do
        subject
        expect(response).to redirect_to(account_tasks_path)
      end

      context "with invalid attributes" do
        let(:parameters) { { task: attributes_for(:invalid_task) } }

        it "does not save task" do
          expect{ subject }.to_not change(Task, :count)
        end

        it "re-render view new task form" do
          subject
          expect(response).to render_template(:new)
        end
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
