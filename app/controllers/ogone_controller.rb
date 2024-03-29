class OgoneController < ApplicationController

  before_action :get_person,    only: [:confirmation, :denial, :error, :cancel]

  def make_a_donation
    render
  end

  def redirect_to_ogone
    params.require(:civility)
    params.require(:email)
    params.require(:first_name)
    params.require(:last_name)
    params.require(:address)
    params.require(:zip_code)
    params.require(:city)
    params.require(:phone)
    params.require(:donation_type)
    params.require(:amount)
    person_params = params.permit(:civility, :email, :first_name, :last_name, :address, :zip_code, :city, :phone, :donation_type)
    person_params.merge!(donation_status: 'En attente', donation_amount: params["amount"].to_i)
    @person = Person.create(person_params)
    if @person.errors.any?
      redirect_to make_a_donation
    else
      if params["donation_type"] == Person::DONATION_TYPE::ONE_TIME_ONLINE
        @digest_params = params_for_regular_order
        compute_digest
        render
      elsif params["donation_type"] == Person::DONATION_TYPE::RECURRING_ONLINE
        @digest_params = params_for_subscription_order
        compute_digest
        render
      elsif params["donation_type"] == Person::DONATION_TYPE::CHECK
        redirect_to don_cheque_path
      else
        render json: {},
               status: :forbidden
      end
    end
  end

  def check_donation
    render
  end

  private

  def params_for_regular_order
    {
        AMOUNT:       params[:amount].to_i * 100,
        CURRENCY:     'EUR',
        EMAIL:        params[:email],
        LANGUAGE:     'fr_FR',
        ORDERID:      @person.order_id,
        OWNERADDRESS: params[:address],
        OWNERTELNO:   params[:phone],
        OWNERTOWN:    params[:city],
        OWNERZIP:     params[:zip_code],
        PSPID:        ENV['PSPID'],
        TP:           'template.html'
    }
  end

  def params_for_subscription_order
    {
        AMOUNT:             params[:amount].to_i * 100,
        CN:                 @person.full_name,
        CURRENCY:           'EUR',
        EMAIL:              params[:email],
        LANGUAGE:           'fr_FR',
        ORDERID:            @person.order_id,
        OWNERADDRESS:       params[:address],
        OWNERTELNO:         params[:phone],
        OWNERTOWN:          params[:city],
        OWNERZIP:           params[:zip_code],
        PSPID:              ENV['PSPID'],
        SUBSCRIPTION_ID:    @person.order_id,
        SUB_AMOUNT:         params[:amount].to_i * 100,
        SUB_COM:            "DonCapajRecurrent",
        SUB_COMMENT:        'DonCapajRecurrent',
        SUB_ENDDATE:        Date.new(2016,12,31),
        SUB_ORDERID:        @person.order_id,
        SUB_PERIOD_MOMENT:  5,
        SUB_PERIOD_NUMBER:  1,
        SUB_PERIOD_UNIT:    'm',
        SUB_STARTDATE:      Date.today,
        SUB_STATUS:         1,
        TP:                 'template.html'
    }
  end

  def compute_digest

    sha_in_passphrase = ENV['SHAIN']

    to_sig = @digest_params.map {|k, v| "#{k}=#{v}#{sha_in_passphrase}"}.join

    @digest = Digest::SHA256.hexdigest(to_sig).upcase

    Rails.logger.info "######### PARAMS TO HASH ###########"
    Rails.logger.info
    Rails.logger.info @digest_params
    Rails.logger.info
    Rails.logger.info "######### VALUE HASHED   ###########"
    Rails.logger.info
    Rails.logger.info @digest
    Rails.logger.info
    Rails.logger.info "#####################################"
  end

  def check_digest
    sha_out_passphrase  = ENV['SHAOUT']

    to_sig              = params.
        except('SHASIGN', :controller, :action).
        select {|_k, v| v.present?}.
        transform_keys!(&:upcase).
        sort_by {|k, _v| k}.
        map     {|k, v| "#{k}=#{v}#{sha_out_passphrase}"}.join

    digest = Digest::SHA256.hexdigest(to_sig).upcase

    Rails.logger.info "#########    PARAMS TO HASH     ###########"
    Rails.logger.info
    Rails.logger.info params.except('SHASIGN', :controller, :action)
    Rails.logger.info
    Rails.logger.info "#########      VALUE HASHED     ###########"
    Rails.logger.info
    Rails.logger.info digest
    Rails.logger.info
    Rails.logger.info "#########  THEORETICAL HASHED   ###########"
    Rails.logger.info
    Rails.logger.info params['SHASIGN']
    Rails.logger.info
    Rails.logger.info "###########################################"

    render nothing: true, status: 301 unless digest == params['SHASIGN']
  end

  def get_person
    @person = Person.find_by_order_id(params[:orderID])
  end
end