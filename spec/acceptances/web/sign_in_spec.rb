require "acceptance_helper"

feature "User sign in", %(
  In order to be able view and complete my tasks
  As an register user
  I want to be able to Sign in
) do
  given(:user) { create(:user) }

  before { visit new_users_session_path }

  scenario "registered user can sign in" do
    fill_in "Email", with: user.email
    fill_in "Password", with: "pass123"
    click_on "Sign in"

    expect(current_path).to eq(account_tasks_path)
    expect(page).to have_content("You successfully signed in")
  end

  scenario "not registered user can not sign in" do
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "321pass"
    click_on "Sign in"

    expect(page).to have_content("Invalid Email or Password")
  end
end
