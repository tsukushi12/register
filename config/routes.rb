Rails.application.routes.draw do
  root 'reserve#time_select'
  get 'reserve/time_select', to: 'reserve#time_select', as: 'time_select'
  get 'reserve/seat_select/:id', to: 'reserve#seat_select', as: 'seat_select'
  get 'reserve/form/:id', to: 'reserve#form', as: 'reserve_form'
  post 'reserve/register/:id', to: 'reserve#register', as: 'reserve_register'
  get 'reserve/auth/:id', to: 'reserve#auth', as: 'reserve_auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  match '*path' => 'application#rescue404', via: :all
end
