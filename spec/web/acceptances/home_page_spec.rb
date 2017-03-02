require "acceptance_helper"

feature "Home page", %(
  In order to be able view all tasks
  As an user
  I want to be able to open home page
) do
  describe "tasks was created" do
    given!(:tasks) { create_list(:task, 2) }

    scenario "view all tasks in system" do
      visit root_path

      expect(current_path).to eq(root_path)

      tasks.each do |task|
        within "#tasks" do
          expect(page).to have_content(task.id)
          expect(page).to have_content(task.created_at)
          expect(page).to have_content(task.name)
          expect(page).to have_content(task.user)
        end
        expect(page).to have_link("Sign In")
        expect(page).to have_link("Sign Up")
      end
    end
  end

  describe "tasks not created" do
    scenario "see message that tasks not created" do
      visit root_path
      expect(page).to have_content("There are no tasks")
    end
  end
end
