class OgoneController < ApplicationController

  before_action :get_person, only: [:confirmation, :denial, :error, :cancel]

  def make_a_donation
    render
  end

  def redirect_to_ogone
    person_params = params.permit(:email, :first_name, :last_name, :address, :zip_code, :city, :phone, :donation_type)
    person_params.merge!(donation_status: 'En attente', donation_amount: params[:amount].to_i)
    @person = Person.create(person_params)
    if @person.errors.any?
      redirect_to :back
    else
      if params[:donation_type] == 'Don en ligne unique'
        compute_digest
        render
      elsif params[:donation_type] == 'Don en ligne récurrent'
        redirect_to :back
      elsif params[:donation_type] == 'Don par chèque'
        redirect_to don_cheque_path
        return
      end
    end
  end

  def check_donation
    render
  end

  def confirmation
    @person.update(donation_status: 'Payé')
    render
  end

  def denial
    @person.update(donation_status: 'Rejeté')
    render
  end

  def error
    @person.update(donation_status: 'Erreur')
    render
  end

  def cancel
    @person.update(donation_status: 'Annulé')
    render
  end

  private

  def compute_digest

    sha_in_passphrase = ENV['SHAIN']

    digest_params = {
        AMOUNT:       params[:amount].to_i * 100,
        CURRENCY:     'EUR',
        EMAIL:        params[:email],
        LANGUAGE:     'fr_FR',
        ORDERID:      @person.order_id,
        OWNERADDRESS: params[:address],
        OWNERTELNO:   params[:phone],
        OWNERTOWN:    params[:city],
        OWNERZIP:     params[:zip_code],
        PSPID:        ENV['PSPID']
    }


    to_sig = digest_params.map {|k, v| "#{k}=#{v}#{sha_in_passphrase}"}.join

    @digest = Digest::SHA256.hexdigest(to_sig).upcase

    Rails.logger.info "######### PARAMS TO HASH ###########"
    Rails.logger.info
    Rails.logger.info digest_params
    Rails.logger.info
    Rails.logger.info "######### VALUE HASHED   ###########"
    Rails.logger.info
    Rails.logger.info @digest
    Rails.logger.info
    Rails.logger.info "#####################################"
  end

  def check_digest
    sha_out_passphrase = ENV['SHAOUT']

    to_sig = params.sort_by{|k, _v| k}.map {|k, v| "#{k}=#{v}#{sha_out_passphrase}"}.join

    digest = Digest::SHA256.hexdigest(to_sig).upcase

    Rails.logger.info "######### PARAMS TO HASH ###########"
    Rails.logger.info
    Rails.logger.info params
    Rails.logger.info
    Rails.logger.info "######### VALUE HASHED   ###########"
    Rails.logger.info
    Rails.logger.info digest
    Rails.logger.info
    Rails.logger.info "#####################################"

  end

  def get_person
    @person = Person.find_by_order_id(params[:orderID])
  end
end