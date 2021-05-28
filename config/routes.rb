Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'chatroom#index'
  get 'login' , to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'message', to: 'messages#create'
  delete 'message', to: 'messages#destroy'
  post 'signup', to: 'users#create'
  resources :posts, except: [:new,:index]
  get 'feed', to: 'posts#index'
  # get  'users/:username/edit', to: 'users#edit'
  # delete 'userdestroy', to: 'users#destroy'
  post 'sessiondisplay', to: 'sessions#update'
  resources :users, except: [:new, :create, :show]
  get 'users/:username', to: 'users#show'
  resources :friends, only: [:create, :update, :destroy, :index]
  resources :group_messages, except: [:index]
  # get 'group', to: 'group_messages#index'
  # get 'group/:id', to: 'group_messages#show'
  # get 'group/new', to: 'group_messages#new'
  # get 'group/:id/edit', to: 'group_messages#edit'
  # post 'groupcreate', to: 'group_messages#create'
  # post 'groupupdate', to: 'group_messages#update'
  # delete 'groupdestroy', to: 'group_messages#destroy'


  mount ActionCable.server, at: '/cable'
end
