namespace :v1 do
  devise_for :customers, skip: [:confirmations, :sessions, :registrations, :passwords]
  devise_scope :customer do
    post 'init' => 'customers#init', as: :init
  end

  resources :wallet, only: [:create, :index] do
    collection do
      patch '' => 'wallet#update', as: :update
      post 'deposits'
      post 'withdrawals'
    end
  end
end