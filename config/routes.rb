Rails.application.routes.draw do
  root 'ogone#make_a_donation'

  post 'redirect_to_ogone' => 'ogone#redirect_to_ogone'

end