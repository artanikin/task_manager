require "acceptance_helper"

feature "User sign out", %(
  In order to be able close session
  As an register user
  I want to be able to Sign out
) do
  given(:user) { create(:user) }

  scenario "registered user sign out" do
    sign_in(user)
    visit account_tasks_path

    click_on "Sign Out"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You successfully signed out")
  end
end
