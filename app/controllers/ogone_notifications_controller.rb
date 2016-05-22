class OgoneNotificationsController < OgoneController
  before_action :check_digest

  skip_before_filter  :verify_authenticity_token

  def notify
    created = OgoneNotification.create(order_id: params[:orderID], message: params.to_json, status: params[:STATUS])
    render 204 and return if created
    render 422
  end

end