class OgoneController < ApplicationController

  def make_a_donation
    render
  end

  def redirect_to_ogone
    @person = Person.create(params.permit(:email, :first_name, :last_name, :address, :zip_code, :city, :phone))
    if @person.errors.any?
      redirect_to :back
      return
    else
      compute_digest
      render
    end
  end

  private




  def compute_digest

    sha_in_passphrase = 'avpezlyetfidacmohoc0'

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
end