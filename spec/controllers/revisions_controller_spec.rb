require 'rails_helper'

RSpec.describe RevisionsController, type: :controller do
  let(:article) { build_stubbed :article }
  let(:revision) { build_stubbed :revision }

  describe "GET #index" do
    it "returns http success" do
      get :index, article_id: article.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, article_id: article.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, article_id: article.id, id: revision.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, article_id: article.id, id: revision.id
      expect(response).to have_http_status(:success)
    end
  end
end
