class OgoneNotificationsController < OgoneController
  before_action :check_digest
  before_action :update_person, only: [:confirmation, :denial, :error, :cancel]
  before_action :send_mail, only: [:confirmation]

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

  def send_mail
    if (ogone_notif = OgoneNotification.find_by(order_id: params[:orderID])) && (ogone_notif.person)
      ApplicationMailer.mail_remerciement(ogone_notif.person.email)
    end
  end

end