module ControllerMacros
  def sign_in_user
    let(:user) { create(:user) }

    before { session[:user_id] = user.id }
  end
end
