require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:user) { build_stubbed :user }
  let(:evil_user) { build_stubbed :user, username: "evilguy", email: "evilguy@666fun.net" }
  let(:articles) { create_list(:random_article, 50, user_id: user.id) }

  describe "#index" do
    it "assigns the first page of articles to @articles" do
      articles.inspect
      get :index
      expect(assigns(:articles).length).to eq(Article.default_per_page)
      expect(response).to render_template(:index)
    end
  end

  describe "#new" do
    before(:each) { sign_in }
    it "assigns Article.new to @article" do
      get :new
      expect(response).to render_template(:new)
      expect(assigns(:article).attributes).to eq(Article.new.attributes)
    end
  end

  describe "#create" do
    let(:valid_article) { build(:random_article, user_id: user.id) }

    context "User not logged in" do 
      it "redirects the user to the login page" do
        post :create, format: :json, article: valid_article.attributes
        expect(response).to have_http_status(401)
      end
    end

    context "User Logged In" do
      before(:each) { sign_in }

      context "Given valid format and article" do
        it "saves the article" do
          post :create, format: :json, article: valid_article.attributes
          expect(JSON.parse(response.body)["success"]).to eq(true)
          expect(JSON.parse(response.body)["errors"]).to be_nil
          expect(JSON.parse(response.body)["article"]["title"]).to eq(valid_article.title)
        end
      end

      context "Given valid format, invalid article" do
        it "does not save the article" do
          invalid_article = valid_article.attributes
          invalid_article[:title] = nil
          post :create, format: :json, article: invalid_article
          expect(JSON.parse(response.body)["success"]).to eq(false)
          expect(JSON.parse(response.body)["errors"]).not_to be_nil
        end
      end
    end
  end

  describe "#show" do
    let(:first_article) { create(:article) }

    it "assigns the article requested by its ID to @article" do
      get :show, id: first_article.slug
      expect(response).to render_template(:show)
      expect(assigns(:article)).to eq (first_article)
    end
  end

  describe "#edit" do
    let(:first_article) { create(:article, user_id: user.id) }

    context "User not logged in" do
      it "redirects to sign in path" do
        get :edit, id: first_article.slug
        expect(response).to redirect_to sign_in_path
      end
    end

    context "User signed in" do    
      describe "If user DOES NOT own the article" do
        it "redirects to root path" do
          sign_in_as(evil_user)
          get :edit, id: first_article.slug
          expect(response).to redirect_to root_path
        end
      end
      describe "If user owns the article" do
        it "assigns @article with the article given for the id" do
          sign_in_as(user)
          get :edit, id: first_article.slug
          expect(response).to render_template(:edit)
          expect(assigns(:article)).to eq(first_article)
        end
      end
    end
  end

  describe "#update" do
    let(:article) { create(:random_article, user_id: user.id) }
    let(:article_updates) { attributes_for(:article, title: "Updated Title") }

    context "User not logged in" do
      it "has status of 401 unauthorized" do
        patch :update, id: article.slug, article: article_updates, format: :json 
        expect(response).to have_http_status(401)
      end
    end

    context "User signed in" do
      describe "If user does own the article" do
        before { sign_in_as(user) }

        it "updates the article with the data provided" do
          patch :update, id: article.slug, article: article_updates, format: :json 
          expect(Article.find_by_slug(article.slug).title).to eq("Updated Title")
        end

        it "responds with json success true and the new article" do
          patch :update, id: article.slug, article: article_updates, format: :json 
          expect(JSON.parse(response.body)["success"]).to eq(true)
          expect(JSON.parse(response.body)["article"]).not_to be_nil
          expect(JSON.parse(response.body)["article"]["title"]).to eq("Updated Title")
        end
      end
      describe "If user DOES NOT own the article" do
        before { sign_in_as(evil_user) }

        it "redirects to root path" do
          patch :update, id: article.slug, article: article_updates, format: :json 
          expect(response).to redirect_to root_path
        end
      end
    end
  end

  describe "#destroy" do
    let(:article) { create(:random_article, user_id: user.id) }

    context "User not logged in" do
      it "has status of 401 unauthorized" do
        delete :destroy, id: article.slug, format: :json
        expect(response).to have_http_status(401)
      end
    end

    context "User signed in" do
      describe "If user does own the article" do
        before { sign_in_as(user) }

        it "destroys the article" do
          delete :destroy, id: article.slug, format: :json
          expect(Article.find_by_slug(article.slug)).to be_nil
        end
        it "responds with JSON success message" do
          delete :destroy, id: article.slug, format: :json
          expect(JSON.parse(response.body)["success"]).to eq(true)
        end
      end

      describe "If user DOES NOT own the article" do
        before { sign_in_as(evil_user) }

        it "redirects to root path" do
          delete :destroy, id: article.slug, format: :json
          expect(response).to redirect_to root_path
        end
        it "does not destroy the article" do
          delete :destroy, id: article.slug, format: :json
          expect(Article.find_by_slug(article.slug)).not_to be_nil
        end
      end
    end
  end
end
