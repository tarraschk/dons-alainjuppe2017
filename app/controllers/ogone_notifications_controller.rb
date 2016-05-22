class OgoneNotificationsController < ApplicationController

  def notify
    OgoneNotification.create(order_id: params[:ORDER_ID], message: request.fullpath)
  end
end