Rails.application.routes.draw do
  root 'search#index', via: :get

  post 'search', to: 'search#results'
end
