require "acceptance_helper"

feature "Display attachment on task card", %(
  In order to view attached file to task
  As an assigned user to task
  I want to be able to see attachemnt on task card
) do
  given(:user) { create(:user) }
  given(:task) { create(:task, user: user) }

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
