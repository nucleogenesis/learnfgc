require "rails_helper"

RSpec.describe "Articles Routes", type: :request do
  describe "index" do
    before { get "/articles" }

    it "Should respond with 200" do
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end

  describe "show" do
    before { get "/articles/article-title" }

    it "Should respond with 200" do
      expect(response.status).to eq(200)
      expect(response).to render_template(:show)
    end
  end

  describe "new" do
    before { get "/articles/new" }

    it "Should respond with 200, render new template" do
      expect(response.status).to eq(200)
      expect(response).to render_template(:new)
    end
  end

  describe "edit" do
    before { get "/articles/article-title/edit" }

    it "Should respond with 200, render edit template" do
      expect(response.status).to eq(200)
      expect(response).to render_template(:edit)
    end
  end
end
