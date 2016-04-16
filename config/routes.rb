Rails.application.routes.draw do
  root 'ogone#make_a_donation'

  post 'redirect_to_ogone'  => 'ogone#redirect_to_ogone'

  get 'merci'               => 'ogone#confirmation'
  get 'don-non-valide'      => 'ogone#denial'
  get 'erreur'              => 'ogone#error'
  get 'don-non-abouti'      => 'ogone#cancel'

  get 'dashboard'           => 'dashboard#dashboard'
  get 'dashboard/people_datatable' => 'dashboard#people_datatable'


end