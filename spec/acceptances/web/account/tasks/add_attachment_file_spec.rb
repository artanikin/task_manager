require "acceptance_helper"

feature "Add files to task", %(
  In order to illustrate my tasks
  As an assigned user to task
  I'd like to be able to attach file
) do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_account_task_path
  end

  scenario "User add file to task" do
    fill_in "Name", with: "New task"
    fill_in "Description", with: "Description for task"
    attach_file "File", "#{Rails.root}/spec/files/ruby.jpeg"
    click_on "Save"

    expect(current_path).to eq(account_tasks_path)
    expect(page).to have_content("Task was successfully created")

    within "#tasks" do
      expect(page).to have_content("New task")
      expect(page).to have_content("Description for task")
    end
  end
end
