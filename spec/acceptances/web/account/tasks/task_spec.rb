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
        expect(page).to have_content(task.created_at)
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
        expect(page).to have_content(task.created_at)
        expect(page).to have_content(task.user)
      end
    end
  end

  feature "display attachments" do
    before { sign_in(user) }

    scenario "in image tag" do
      create(:attachment, task: task)

      visit account_task_path(task)

      within ".task-card" do
        expect(page).to have_css("img[src*=\"ruby.jpeg\"]")
      end
    end

    scenario "like a link to file" do
      path = "#{Rails.root}/spec/files/simple.txt"
      create(:attachment, task: task, file: Rack::Test::UploadedFile.new(File.open(path)))

      visit account_task_path(task)

      within ".task-card" do
        expect(page).to have_link(task.attachment.file.identifier, href: task.attachment.file.url)
      end
    end
  end
end
