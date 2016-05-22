class OgoneNotificationsController < OgoneController
  before_action :check_digest
  before_action :update_person, only: [:confirmation, :denial, :error, :cancel]

  skip_before_filter  :verify_authenticity_token

  def notify
    created = OgoneNotification.create(order_id: params[:orderID], message: params.to_json, status: params[:STATUS])
    render status: 204, nothing: true and return if created
    render status: 422, nothing: true
  end

  private

  def update_person
    @person.update(status: params[:STATUS])
  end

end