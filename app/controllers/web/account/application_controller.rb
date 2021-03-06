class Web::Account::ApplicationController < Web::ApplicationController
  before_action :authenticate_user!

  private

  def authenticate_user!
    redirect_to new_users_session_path, alert: "Please, sign in" unless user_signed_in?
  end
end
