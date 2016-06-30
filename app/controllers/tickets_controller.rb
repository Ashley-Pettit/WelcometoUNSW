require 'will_paginate/array'

class TicketsController < ApplicationController
  rescue_from ZendeskAPI::Error::NetworkError, with: :zendesk_offline

  def index
    #to_a! is used to raise an error if the variable does not exist (E.g. API Offline)
    @tickets = client.tickets.to_a!
    #Hopefully not overengineering but I needed the last updated at the top!
    @tickets.sort { |a,b| a.updated_at <=> b.updated_at }
    #Using will_paginate to make pages
    @tickets = @tickets.paginate(page: params[:page], per_page: 25)
  end


  def show
    #This is calling the client method which uses the zendesk api gem
    @ticket = client.tickets.find(id: params[:id])
    #Handling an invalid ticket
    if @ticket.nil?
      flash[:error] = "Sorry this ticket could not be found"
      redirect_to root_path
    end
  end

  private

  #Configuration requirements to login to the Zendesk API
  def client
    ZendeskAPI::Client.new do |config|
      config.username = "ashley@digital380.com.au"
      config.password = "676800Ash"
      config.url = "https://kings-landing.zendesk.com/api/v2"
    end
  end

  #Handle offline API. Called by the rescue_from method at the top of this controller
  def zendesk_offline
    render :zendesk_offline
  end

end
