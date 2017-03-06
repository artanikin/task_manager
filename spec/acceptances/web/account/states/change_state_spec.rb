require "acceptance_helper"

feature "Change state", %(
  In order to be able to controle state of task
  As an assigned user
  I want to be able to change state
) do
  given(:user) { create(:user) }
  given(:admin) { create(:user, role: "admin") }
  given!(:task) { create(:task, user: user) }

  feature "Autenticate user" do
    before { sign_in(user) }

    scenario "can change state of task" do
      visit account_tasks_path

      within "#tasks" do
        click_on "start"
      end

      within "#tasks" do
        expect(page).to have_content("started")
        expect(page).to have_link("finish", href: "/account/tasks/#{task.id}/states/finish")
      end

      expect(page).to have_content("State successfully changed")
    end
  end

  feature "Admin user" do
    before { sign_in(admin) }

    scenario "can change state of task" do
      visit account_tasks_path

      within "#tasks" do
        click_on "start"
      end

      within "#tasks" do
        expect(page).to have_content("started")
        expect(page).to have_link("finish", href: "/account/tasks/#{task.id}/states/finish")
      end

      expect(page).to have_content("State successfully changed")
    end
  end
end
