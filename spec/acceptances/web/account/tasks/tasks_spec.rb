require "acceptance_helper"

feature "Users tasks", %(
  In order to be able view all my tasks
  As an registered user
  I want to be able to see all tasks assigned me
) do
  given!(:user) { create(:user) }
  given!(:admin) { create(:user, role: "admin") }
  given!(:tasks) { create_list(:task, 2, user: user) }
  given!(:admin_tasks) { create_list(:task, 2, user: admin) }

  feature "Authenticate user" do
    before { sign_in(user) }

    scenario "see all assigned tasks" do
      visit account_tasks_path

      expect(page).to have_link("New task")
      expect(page).to have_link("Edit")
      expect(page).to have_link("Delete")

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

  feature "Authenticate admin user" do
    before { sign_in(admin) }

    scenario "see all users tasks" do
      visit account_tasks_path

      expect(page).to have_link("New task")
      expect(page).to have_link("Edit")
      expect(page).to have_link("Delete")

      within "#tasks" do
        expect(page).to have_css("tbody tr", count: 4)

        all_tasks = tasks + admin_tasks

        all_tasks.each do |task|
          expect(page).to have_content(task.id)
          expect(page).to have_content(task.name)
          expect(page).to have_content(task.description)
          expect(page).to have_content(task.state)
          expect(page).to have_content(task.created_at)
          expect(page).to have_content(task.user)
        end
      end
    end
  end

  scenario "Not authenticated user not see My Tasks link" do
    visit root_path
    expect(page).to_not have_link("My Tasks")
  end
end
