class DashboardController < ApplicationController
  before_action :basic_authentication

  def basic_authentication
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USERNAME'] &&
          password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def dashboard
    render
  end

  def people_datatable
    render json: PersonDatatable.new(view_context)
  end

  def set_donation_received
    Person.find(params[:id]).update(status: 100)
    render json: {done: 'ok'}
  end
end