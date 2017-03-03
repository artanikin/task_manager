module ControllerMacros
  def sign_in_user(role = "user")
    let(:user) { create(:user, role: role) }

    before { session[:user_id] = user.id }
  end
end
