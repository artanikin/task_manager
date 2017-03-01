class Web::UsersController < Web::ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge(role: "user"))

    if @user.save
      redirect_to root_path, notice: "You successfully signed up"
    else
      flash[:alert] = "You are not signed up"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
