class Web::UsersController < Web::ApplicationController
  def new
    respond_with(@user = User.new)
  end

  def create
    respond_with(@user = User.create(user_params.merge(role: "user")),
                 location: -> { new_users_session_path })
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
