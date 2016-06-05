Rails.application.routes.draw do
  root 'ogone#make_a_donation'

  get 'don_cheque'                        => 'ogone#check_donation'

  post 'redirect_to_ogone'                => 'ogone#redirect_to_ogone'

  get 'merci'                             => 'ogone_notifications#confirmation'
  get 'don-non-valide'                    => 'ogone_notifications#denial'
  get 'erreur'                            => 'ogone_notifications#error'
  get 'don-non-abouti'                    => 'ogone_notifications#cancel'
  post 'ogone_notifications/notify'       => 'ogone_notifications#notify'

  get 'dashboard'                         => 'dashboard#dashboard'
  get 'dashboard/people_datatable'        => 'dashboard#people_datatable'
  post 'dashboard/set_donation_received'  => 'dashboard#set_donation_received'


end