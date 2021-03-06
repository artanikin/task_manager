require "acceptance_helper"

feature "Edit user task", %(
  In order to change task
  As an assigned user
  I want to be able to edited my tasks
) do
  given!(:user) { create(:user) }
  given!(:task) { create(:task, user: user) }

  background do
    sign_in(user)
    visit edit_account_task_path(task)
  end

  feature "authenticate assigned to task user" do
    scenario "can edit task" do
      expect(page).to_not have_select("User")

      fill_in "Name", with: "Update name"
      fill_in "Description", with: "Update description"
      click_on "Save"

      expect(current_path).to eq(account_tasks_path)
      expect(page).to have_content("Task was successfully updated")
    end

    context "with invalid parameters" do
      scenario "can't edit task" do
        fill_in "Name", with: ""
        fill_in "Description", with: ""
        click_on "Save"

        expect(page).to have_content("Task not updated")
        expect(page).to have_content("Name can't be blank")
      end
    end
  end
end
