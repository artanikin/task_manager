Rails.application.routes.draw do
  scope module: "web" do
    # TODO: replace this temp root routes
    root "users#new"

    # resources :users, only: [:new, :create]
    # resources :sessions, only: [:new, :create, :destroy]

    resource "users", only: [:new, :create], path_names: { new: "sign_up" } do
      resource :session, only: [], path: "" do
        get    :new,     path: "sign_in", as: :new
        post   :create,  path: "sign_in"
        delete :destroy, path: "sign_out", as: :destroy
      end
    end
  end
end
