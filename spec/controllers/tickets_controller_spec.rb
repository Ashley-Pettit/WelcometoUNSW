require 'rails_helper'

describe TicketsController do
  context 'index' do
    it 'returns a list of up to 100 tickets whilist zendesk is online' do
      get :index
      expect(assigns(:tickets)).to be_present
    end
  end

  context 'show' do
    it 'should show a particular ticket in more detail' do
      get :show, id: 50
      expect(response).to render_template(:show)
    end
  end

  context "ticket doesn't exist" do
    it "it renders the index page with an error" do
      get :show, id: 112481321
      expect(flash[:error]).to match("Sorry this ticket could not be found")
    end
  end

  context "zendesk_offline" do
    it "When the API is offline a page showing an offline message is displayed " do
      #Not sure how to best test this
    end
  end

end
