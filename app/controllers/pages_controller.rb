class PagesController < ApplicationController
  def letsencrypt
    render text: params[:LE_HTTP_CHALLENGE_RESPONSE_BEGIN]+"."+ENV['LE_HTTP_CHALLENGE_RESPONSE_END']
  end
end