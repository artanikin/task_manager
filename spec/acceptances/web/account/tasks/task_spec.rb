require "acceptance_helper"

feature "Task card", %(
  In order to view all task information
  As an assigned user to task
  I want to be able to visit task card
) do
  given(:user) { create(:user) }
  given(:admin) { create(:user, role: "admin") }
  given(:task) { create(:task, user: user) }

  feature "assigned user" do
    before { sign_in(user) }

    scenario "can visit task card" do
      visit account_task_path(task)

      within ".task-card" do
        expect(page).to have_content(task.id)
        expect(page).to have_content(task.name)
        expect(page).to have_content(task.description)
        expect(page).to have_content(I18n.l(task.created_at.localtime, format: :short))
        expect(page).to_not have_content(task.user)
      end
    end
  end

  feature "admin user" do
    before { sign_in(admin) }

    scenario "can visit task card" do
      visit account_task_path(task)

      within ".task-card" do
        expect(page).to have_content(task.id)
        expect(page).to have_content(task.name)
        expect(page).to have_content(task.description)
        expect(page).to have_content(I18n.l(task.created_at.localtime, format: :short))
        expect(page).to have_content(task.user)
      end
    end
  end
end
