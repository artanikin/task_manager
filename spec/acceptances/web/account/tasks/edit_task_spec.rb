require "acceptance_helper"

feature "Edit user task", %(
  In order to change task
  As an assigned user
  I want to be able to edited my tasks
) do
  given!(:user) { create(:user) }
  given!(:task) { create(:task) }

  feature "authenticate user" do
    before { sign_in(user) }

    context "assigned to task" do
      before do
        task.update(user_id: user.id)
        visit edit_account_task_path(task)
      end

      scenario "can edit task" do
        fill_in "Name", with: "Update name"
        fill_in "Description", with: "Update description"
        click_on "Save"

        expect(current_path).to eq(account_tasks_path)
        expect(page).to have_content("Task was successfully updated")
      end

      context "with invalid parameters" do
        scenario "can`t edit task" do
          fill_in "Name", with: ""
          fill_in "Description", with: ""
          click_on "Save"

          expect(page).to have_content("Task not updated")
          expect(page).to have_content("Name can't be blank")
        end
      end
    end

    context "not assigned to task" do
      scenario "can not edit task" do
        visit account_tasks_path
        expect(page).to_not have_link("Edit")
      end
    end
  end

  scenario "not authenticated user not see Edit button" do
    visit account_tasks_path
    expect(page).to have_content("Please, sign in")
    expect(current_path).to eq(new_users_session_path)
  end
end