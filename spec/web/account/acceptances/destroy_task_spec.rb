require "acceptance_helper"

feature "Destroy task", %(
  In order to remove not actual task
  As an assigned user
  I want to be able to destroy task
) do
  given!(:user) { create(:user) }
  given!(:task) { create(:task, user: user) }

  feature "authenticate user" do
    before { sign_in(user) }

    context "assigned to task" do
      before { visit account_tasks_path }

      scenario "can destroy task" do
        within "#tasks" do
          click_on "Delete"
        end

        expect(page).to_not have_content(task.name)
        expect(page).to have_content("Task was successfully deleted")
        expect(current_path).to eq(account_tasks_path)
      end
    end
  end
end
