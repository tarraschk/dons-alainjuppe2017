class DashboardController < ApplicationController
  before_action :basic_authentication

  def basic_authentication
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' &&
          password == 'AJa1ss2d!'
    end
  end

  def dashboard
    render
  end

  def people_datatable
    respond_to do |format|
      format.html
      format.json { render json: PersonDatatable.new(view_context) }
    end
  end
end