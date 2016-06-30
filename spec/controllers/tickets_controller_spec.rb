require 'rails_helper'

describe TicketsController do
  context 'index' do
    it 'returns a list of up to 100 tickets whilist zendesk is online' do
      get :index
      expect(assigns(:tickets)).to be_present
    end
  end

  context 'show' do
    it 'show returns 1 ticket' do
      get :show, id: 1
      expect(assigns(:ticket)).to be_present
    end
  end

  context 'Zendesk Offline' do
    it 'the error ZendeskAPI::Error::NetworkError is rescued by the function zendesk_offline which will render the zendesk_offline view rather than attempt to load the index or show methods' do
      get :index
      assigns(:ticket) == []
      expect(assigns(:ticket)).to be_present
    end
  end


end
