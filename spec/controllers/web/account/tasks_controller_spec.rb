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

    context "authenticated admin user" do
      let(:admin_tasks) { create_list(:task, 2, user: user) }
      let(:another_user_tasks) { create_list(:task, 2) }

      sign_in_user("admin")

      before { subject }

      it "populates array of all tasks" do
        all_tasks = admin_tasks + another_user_tasks
        expect(assigns(:tasks)).to match_array(all_tasks)
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

      it "build new attachment for task" do
        expect(assigns(:task).attachment).to be_a_new(Attachment)
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
    let(:bob) { create(:user) }
    let(:parameters) { { task: attributes_for(:task) } }

    subject { post :create, params: parameters }

    context "authenticated user" do
      sign_in_user

      it "create new task" do
        expect{ subject }.to change(user.tasks, :count).by(1)
      end

      it "can not assign task for another user" do
        parameters = { task: attributes_for(:task, user_id: bob) }
        expect{ subject }.to_not change(bob.tasks, :count)
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

      context "as an admin" do
        let(:parameters) { { task: attributes_for(:task, user_id: bob) } }

        before { user.update(role: "admin") }

        it "can assign task to another user" do
          user.reload
          expect{ subject }.to change(bob.tasks, :count)
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

  describe "GET #edit" do
    let!(:task) { create(:task) }

    subject { get :edit, params: { id: task } }

    context "authenticated user" do
      sign_in_user

      context "assigned user to task" do
        before do
          task.update(user_id: user.id)
          subject
        end

        it "assigns Task to @task" do
          expect(assigns(:task)).to eq(task)
        end

        it "render view edit" do
          expect(response).to render_template(:edit)
        end
      end

      context "not assigned user to task" do
        it "redirect to account tasks list" do
          subject
          expect(response).to redirect_to(account_tasks_path)
        end
      end

      context "admin user" do
        it "assigns Task to @task" do
          subject
          expect(assigns(:task)).to eq(task)
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

  describe "PATCH #update" do
    let!(:task) { create(:task, name: "Name placeholder", description: "Desc placeholder") }
    let(:parameters) do
      { id: task, task: { name: "Changed name", description: "Changed description" } }
    end

    subject { patch :update, params: parameters }

    context "authenticated user" do
      sign_in_user

      context "assigned user to task" do
        before do
          task.update(user: user)
          subject
        end

        it "changed task attributes" do
          task.reload
          expect(task.name).to eq(parameters[:task][:name])
          expect(task.description).to eq(parameters[:task][:description])
        end

        it "can not assigning task to another user" do
          john = create(:user)
          parameters = { id: task,
             task: { name: "Changed name", description: "Changed description", user_id: john } }
          subject
          task.reload

          expect(task.name).to eq(parameters[:task][:name])
          expect(task.description).to eq(parameters[:task][:description])
          expect(task.user).to eq(user)
        end

        it "redirect to account task list" do
          expect(response).to redirect_to(account_tasks_path)
        end

        context "with invalid params" do
          let(:parameters) { { id: task, task: { name: nil } } }

          it "can not change task attributes" do
            task.reload
            expect(task.name).to eq("Name placeholder")
            expect(task.description).to eq("Desc placeholder")
          end
        end
      end

      context "not assigned user to task" do
        before { subject }

        it "can not change task attributes" do
          task.reload
          expect(task.name).to eq("Name placeholder")
          expect(task.description).to eq("Desc placeholder")
        end

        it "redirect to account tasks list" do
          subject
          expect(response).to redirect_to(account_tasks_path)
        end
      end

      context "admin user" do
        let(:john) { create(:user) }
        let(:parameters) do { id: task,
            task: { name: "Changed name", description: "Changed description", user_id: john } }
        end

        sign_in_user("admin")

        it "assigned user to task" do
          subject
          task.reload

          expect(task.name).to eq(parameters[:task][:name])
          expect(task.description).to eq(parameters[:task][:description])
          expect(task.user).to eq(john)
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

  describe "DELETE #destroy" do
    let!(:task) { create(:task) }

    subject { delete :destroy, params: { id: task } }

    describe "authenticated user" do
      sign_in_user

      context "assigned user" do
        before { task.update(user: user) }

        it "delete tasks" do
          expect{ subject }.to change(user.tasks, :count).by(-1)
        end

        it "redirect to account tasks list" do
          subject
          expect(response).to redirect_to(account_tasks_path)
        end
      end

      context "admin user" do
        sign_in_user("admin")

        it "can delete another user tasks" do
          expect{ subject }.to change(Task, :count)
        end
      end

      context "not assigned user" do
        it "can not delete task" do
          expect{ subject }.to_not change(Task, :count)
        end

        it "redirect to account tasks list" do
          subject
          expect(response).to redirect_to(account_tasks_path)
        end
      end
    end

    describe "not authenticated user" do
      it "can not delete task" do
        expect{ subject }.to_not change(Task, :count)
      end

      it "redirect to sign in form" do
        subject
        expect(response).to redirect_to(new_users_session_path)
      end
    end
  end
end
