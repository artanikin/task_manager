Rails.application.routes.draw do
  scope module: "web" do
    root "tasks#index"

    resources :tasks, only: [:index]

    resource "users", only: [:new, :create], path_names: { new: "sign_up" } do
      resource :session, only: [], path: "" do
        get    :new,     path: "sign_in", as: :new
        post   :create,  path: "sign_in"
        delete :destroy, path: "sign_out", as: :destroy
      end
    end

    namespace :account do
      resources :tasks, only: [:index, :new, :create, :edit, :update]
    end
  end
end
