Rails.application.routes.draw do
  root 'ogone#make_a_donation'

  post 'redirect_to_ogone'  => 'ogone#redirect_to_ogone'

  get 'merci'               => 'ogono#confirmation'
  get 'don-non-valide'      => 'ogono#denial'
  get 'erreur'              => 'ogono#error'
  get 'don-non-abouti'      => 'ogono#cancel'

  get 'dashboard'           => 'dashboard#dashboard'
  get 'dashboard/people_datatable' => 'dashboard#people_datatable'


end