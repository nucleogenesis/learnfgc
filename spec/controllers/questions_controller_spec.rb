require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { build_stubbed :user }
  let!(:article) { create(:article, user_id: user.id) }
  let!(:question) { create(:question, article_id: article.id, user_id: user.id) }

  describe "GET #index" do
    it "returns http success" do
      get :index, article_id: article.slug

      expect(response).to have_http_status(:success)
    end

    it "assigns @questions with all questions for the article" do
      get :index, article_id: article.slug

      expect(assigns(:questions).count).to eq(1)
    end
  end

  describe "GET #new" do

    describe "when user is logged in" do
      before(:each) { sign_in }

      it "returns http success" do
        get :new, article_id: article.slug
        expect(response).to have_http_status(:success)
      end

      it "assigns a Question.new to @question" do
        get :new, article_id: article.slug
        expect(assigns(:question).attributes).to eq(Question.new.attributes)
      end
    end

    describe "when user IS NOT logged in" do
      it "redirects to sign in path" do
        get :new, article_id: article.slug

        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "GET #edit" do

    describe "when user is logged in" do
      before(:each) { sign_in }

      it "returns http success" do
        get :edit, article_id: article.slug, id: question.id
        expect(response).to have_http_status(:success)
      end

      it "assigns the requested question to @question" do
        get :edit, article_id: article.slug, id: question.id
        expect(assigns(:question)).to eq(question)
      end
    end

    describe "when user IS NOT logged in" do
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, article_id: article.slug, id: question.id
      expect(response).to have_http_status(:success)
    end

    it "assigns the requested question to @question" do
      get :show, article_id: article.slug, id: question.id
      expect(assigns(:question)).to eq(question)
    end
  end

  describe "POST #create" do
    let!(:new_question) { attributes_for(:question, user_id: user.id, article_id: article.id) }

    describe "user is logged in" do
      before(:each) { sign_in_as(user) }
      
      context "given a valid question" do
        it "creates the question, and gets successfull JSON" do
          post :create, article_id: article.slug, question: new_question

          expect(JSON.parse(response.body)["success"]).to eq(true)
        end
      end

      context "given a bad question" do
        it "does not create the question and returns JSON error object" do
          new_question[:title] = nil
          post :create, article_id: article.slug, question: new_question
          expect(JSON.parse(response.body)["success"]).to eq(false)
        end
      end
    end
    describe "user IS NOT logged in" do
      it "returns a 401 unauthorized status" do
        sign_out
        post :create, format: :json, article_id: article.slug, question: new_question
        expect(response).to have_http_status(401)
      end
    end
  end

end
