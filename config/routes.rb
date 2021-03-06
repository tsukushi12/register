Rails.application.routes.draw do
  root 'reserve#time_select'
  
  get 'reserve/time_select', to: 'reserve#time_select', as: 'time_select'
  get 'reserve/seat_select/:id', to: 'reserve#seat_select', as: 'seat_select'
  get 'reserve/form/:id', to: 'reserve#form', as: 'reserve_form'
  post 'reserve/register/:id', to: 'reserve#register', as: 'reserve_register'
  get 'reserve/auth/:id', to: 'reserve#auth', as: 'reserve_auth'
  get 'reserve/resend'
  post 'reserve/resend', to: 'reserve#resend_mail', as: 'reserve_resend_mail'
  get 'reserve/cancel_form/:id', to: 'reserve#cancel_form', as: 'reserve_cancel_form'
  post 'reserve/cancel/:id', to: 'reserve#cancel', as: 'reserve_cancel'
  get 'help', to: 'reserve#help'
  get 'reserve/message', to: 'reserve#message', as: 'message'

  get 'admin', to: 'admin#index'
  get 'admin/info', to: 'admin#info'
  get 'admin/login'
  post 'admin/login', to: 'admin#authenticate', as: 'admin_auth'
  delete 'admin/logout', to: 'admin#logout', as: 'admin_logout'
  post 'admin/attend'
  post 'admin/call', to: 'admin#call_mail_send'
  post 'admin/apollo', to: 'admin#apollo_mail_send'
  post 'admin/cancel'

  # if Rails.env.development?
    # mount LetterOpenerWeb::Engine, at: "/letter_opener"
  # end

  match '*path' => 'application#rescue404', via: :all
end
