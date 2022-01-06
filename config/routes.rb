Rails.application.routes.draw do
  # devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    draw("api/v1")
  end
  get '/', to: redirect('/404')
end
