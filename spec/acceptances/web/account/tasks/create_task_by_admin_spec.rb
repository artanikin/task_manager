require "acceptance_helper"

feature "Create new task", %(
  In order to be able to set new task by another user
  As an Administrator
  I want to be able to create new task
) do
  given!(:admin) { create(:user, role: "admin") }
  given!(:user) { create(:user) }
  given!(:task_attributes) { attributes_for(:task) }

  feature "Authenticate admin user" do
    before { sign_in(admin) }

    scenario "create new task" do
      visit new_account_task_path

      fill_in "Name", with: task_attributes[:name]
      fill_in "Description", with: task_attributes[:description]
      select user, from: "User"
      click_on "Save"

      expect(current_path).to eq(account_tasks_path)
      expect(page).to have_content("Task was successfully created")

      within "#tasks" do
        expect(page).to have_content(task_attributes[:name])
        expect(page).to have_content(task_attributes[:description])
        expect(page).to have_content(user.email)
      end
    end
  end
end
