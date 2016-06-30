require 'will_paginate/array'

class TicketsController < ApplicationController
  #HANDLE API BEING OFFLINE
  rescue_from ZendeskAPI::Error::NetworkError, with: :zendesk_offline

  def index
    @tickets = client.tickets.to_a!
    #Using will_paginate to make pages
    @tickets = @tickets.paginate(page: params[:page], per_page: 25)
  end


  def show
    @ticket = client.tickets.find(id: params[:id])

    #HANDLE INVALID ID
    if @ticket.nil?
      flash[:alert] = "Sorry this ticket could not be found"
      redirect_to root_path
    end
  end

  #This method is used purely to see the results of the API
  def test
    render :json => client.tickets
  end

  private

  def client
    ZendeskAPI::Client.new do |config|
      config.username = "ashley@digital380.com.au"
      config.password = "676800Ash"
      config.url = "https://kings-landing.zendesk.com/api/v2"
    end
  end

  def zendesk_offline
    render :zendesk_offline
  end

end

#Alternate way without Zendesk gem

# response = HTTParty.get("#{client_instance}/api/v2/tickets/#{ticket_id}.json", :basic_auth => basic_auth_details)
