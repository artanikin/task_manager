require "acceptance_helper"

feature "Destroy another user task", %(
  In order to remove not actual
  As an admin user
  I want to be able to destroy another user task
) do
  given!(:admin) { create(:user, role: "admin") }
  given!(:user) { create(:user) }
  given!(:task) { create(:task, user: user) }

  feature "Authenticated admin user" do
    before { sign_in(admin) }

    context "not assigned to task" do
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
