class TicketsController < ApplicationController

  #view all => get '/ticket' #show a maximum of 25 tickets.
  def index
    # Should this actually make a database or is that overcomplicating the problem?

    # @tickets = Ticket.all OR
    # OR @tickets = insert here the api call
    # *Remember to handle the api if offline.

    #For Testing only

    #basic auth >> Don't use O auth
    #how to ask for a ticket


    @tickets = ['ticket1', 'ticket2']

    @tickets_page = Post.paginate(:page => params[:page])
    or, use an explicit "per page" limit:
    Post.paginate(:page => params[:page], :per_page => 25)

    ## render page links in the view:
    <%= will_paginate @posts %>


  end

  # view one => get '/ticket/:id'
  def show
    if true #id exist
      # show the ticket
      @ticket = params[:id]
    else #id doesn't exist
      # render 404 error
    end
  end

end
