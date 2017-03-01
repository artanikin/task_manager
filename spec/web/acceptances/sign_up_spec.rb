require "acceptance_helper"

feature "User sign up", %(
  In order to be able complete task
  As an user
  I want to be able to sign up
) do
  before { visit new_user_path }

  scenario "user can sign up" do
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "pass123"
    fill_in "Confirmation", with: "pass123"
    click_on "Sign up"

    # expect(current_path).to eq(new_user_path)
    # expect(page).to have_content("Sign out")
    expect(page).to have_content("You successfully signed up")
  end

  scenario "user can not sign up with out email" do
    fill_in "Password", with: "pass123"
    fill_in "Confirmation", with: "pass123"
    click_on "Sign up"
    expect(page).to have_content("You are not signed up")
    expect(page).to have_content("Email is incorrect format")
  end

  scenario "user can not sign up with out password" do
    fill_in "Email", with: "user@example.com"
    click_on "Sign up"

    expect(page).to have_content("You are not signed up")
    expect(page).to have_content("Password can't be blank")
  end

  scenario "user can not sign up when password not confirmed" do
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "pass123"
    click_on "Sign up"

    expect(page).to have_content("You are not signed up")
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
