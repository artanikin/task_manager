shared_examples "Not authenticated user" do
  it "redirect_to sign in page" do
    subject
    expect(response).to redirect_to(new_users_session_path)
  end
end
