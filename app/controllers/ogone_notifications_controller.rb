class OgoneNotificationsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def notify
    OgoneNotification.create(order_id: params[:orderID], message: request.fullpath)
  end
end