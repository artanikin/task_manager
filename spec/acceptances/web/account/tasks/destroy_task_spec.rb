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
      scenario "can destroy task" do
        visit account_tasks_path

        within("#tasks") { click_on "Delete" }

        expect(current_path).to eq(account_tasks_path)
        expect(page).to have_content("Task was successfully deleted")
        expect(page).to_not have_content(task.name)
      end
    end
  end
end
