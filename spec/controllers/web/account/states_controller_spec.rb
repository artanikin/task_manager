require "rails_helper"

RSpec.describe Web::Account::StatesController, type: :controller do
  describe "PATCH #update" do
    let(:bob) { create(:user) }
    let(:john) { create(:user, role: "admin") }
    let(:task_new) { create(:task, user: bob) }
    let(:task_started) { create(:task, user: bob, state: "started") }
    let(:task_finished) { create(:task, user: bob, state: "finished") }

    context "authenticated user" do
      before { session[:user_id] = bob.id  }

      context "assigned user" do
        it "can change state from new to started" do
          patch :update, params: { task_id: task_new.id, id: "start" }
          task_new.reload
          expect(task_new.state).to eq("started")
        end

        it "can change state from started to finished" do
          patch :update, params: { task_id: task_started.id, id: "finish" }
          task_started.reload
          expect(task_started.state).to eq("finished")
        end

        it "can not change state from finished to start" do
          patch :update, params: { task_id: task_finished.id, id: "start" }
          task_finished.reload
          expect(task_finished.state).to_not eq("started")
        end

        it "redirect to account task list" do
          patch :update, params: { task_id: task_new.id, id: "start" }
          expect(response).to redirect_to(account_tasks_path)
        end
      end

      context "not assigned user" do
        before { task_new.update(user: john) }

        it "can not change state" do
          patch :update, params: { task_id: task_new.id, id: "start" }
          task_new.reload
          expect(task_new.state).to_not eq("started")
        end
      end
    end

    context "admin user" do
      before { session[:user_id] = john }

      it "can change state" do
        patch :update, params: { task_id: task_new.id, id: "start" }
        task_new.reload
        expect(task_new.state).to eq("started")
      end
    end

    context "not authenticated user" do
      it "redirect_to sign in page" do
        patch :update, params: { task_id: task_new.id, id: "start" }
        expect(response).to redirect_to(new_users_session_path)
      end
    end
  end
end
