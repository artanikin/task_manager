require "acceptance_helper"

feature "Create new task", %(
  In order to be able to create new task
  As an registered user
  I want to be able to create new task
) do
  given!(:user) { create(:user) }
  given!(:task_attributes) { attributes_for(:task) }

  feature "Authenticate user" do
    before { sign_in(user) }

    scenario "create new task" do
      visit new_account_task_path

      fill_in "Name", with: task_attributes[:name]
      fill_in "Description", with: task_attributes[:description]
      click_on "Create"

      expect(current_path).to eq(account_tasks_path)
      expect(page).to have_content("Task was successfully created")

      within "#tasks" do
        expect(page).to have_content(task_attributes[:name])
        expect(page).to have_content(task_attributes[:description])
      end
    end
  end
end
