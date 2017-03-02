Rails.application.routes.draw do
  scope module: "web" do
    # TODO: replace this temp root routes
    root "users#new"

    resources :users, only: [:new, :create]
    resources :sessions, only: [:new, :create]
  end
end
