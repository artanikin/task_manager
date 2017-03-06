require "acceptance_helper"

feature "Edit user task", %(
  In order to change task
  As an admin user
  I want to be able to edited my tasks
) do
  given!(:admin) { create(:user, role: "admin") }
  given!(:user) { create(:user) }
  given!(:task) { create(:task) }

  background do
    sign_in(admin)
    visit edit_account_task_path(task)
  end

  feature "Authenticate admin user" do
    scenario "can edit task" do
      fill_in "Name", with: "Update name"
      fill_in "Description", with: "Update description"
      select user, from: "User"
      click_on "Save"

      expect(current_path).to eq(account_tasks_path)
      expect(page).to have_content("Task was successfully updated")

      within "#tasks" do
        expect(page).to have_content("Update name")
        expect(page).to have_content("Update description")
        expect(page).to have_content(user.email)
      end
    end

    scenario "can't edit task with invalid params" do
      fill_in "Name", with: ""
      fill_in "Description", with: ""
      select "", from: "User"
      click_on "Save"

      expect(page).to have_content("Task not updated")
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("User must exist")
    end
  end
end
