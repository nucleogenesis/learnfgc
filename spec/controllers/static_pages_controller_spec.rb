require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "#home" do
    it "resolves http status 200" do
      get :home
      expect(response).to have_http_status 200
    end
  end
end
