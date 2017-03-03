require "acceptance_helper"

feature "Users tasks", %(
  In order to be able view all my tasks
  As an registered user
  I want to be able to see all tasks assigned me
) do
  given!(:user) { create(:user) }
  given!(:tasks) { create_list(:task, 2, user: user) }

  feature "Authenticate user" do
    before { sign_in(user) }

    scenario "see all assigned tasks" do
      visit account_tasks_path

      expect(page).to have_link("New task")
      expect(page).to have_link("Edit")

      within "#tasks" do
        expect(page).to have_css("tbody tr", count: 2)

        tasks.each do |task|
          expect(page).to have_content(task.id)
          expect(page).to have_content(task.name)
          expect(page).to have_content(task.description)
          expect(page).to have_content(task.state)
          expect(page).to have_content(task.created_at)
        end
      end
    end
  end

  scenario "Not authenticated user not see My Tasks link" do
    visit root_path
    expect(page).to_not have_link("My Tasks")
  end
end
