require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create :user }
  let(:evil_user) { create(:user, username: "The Devil", email: "saddams_gal@gehenna.net") }
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
      before(:each) { sign_in_as(user) }

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
      context "editing question own by signed in user" do
        before(:each) { sign_in_as(user) }

        it "returns http success" do
          get :edit, article_id: article.slug, id: question.id
          expect(response).to have_http_status(:success)
        end

        it "assigns the requested question to @question" do
          get :edit, article_id: article.slug, id: question.id
          expect(assigns(:question)).to eq(question)
        end
      end

      context "trying to edit question not owned" do
        before(:each) { sign_in_as(evil_user) }

        it "redirects to root" do
          get :edit, article_id: article.slug, id: question.id
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "when user IS NOT logged in" do
      it "redirects to sign_in" do
        get :edit, article_id: article.slug, id: question.id
        expect(response).to redirect_to sign_in_path
      end
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

        it "does not let a question be made for a user other than the current one" do
          new_question[:user_id] = evil_user.id
          post :create, article_id: article.slug, question: new_question
          expect(response).to redirect_to root_path
        end

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

  describe "PATCH #update" do
    let(:new_question) { attributes_for(:question, user_id: user.id, article_id: article.id) }

    describe "user is logged in" do
      before(:each) { sign_in_as(user) }

      context "given a valid question" do

        it "updates the question, and gets successfull JSON" do
          new_question[:title] = "NEW TITLE"
          patch :update, format: :json, article_id: article.slug, question: new_question, id: question.id

          expect(JSON.parse(response.body)["success"]).to eq(true)
          expect(JSON.parse(response.body)["question"]["title"]).to eq("NEW TITLE")
        end
      end

      context "given a bad question" do
        it "does not update the question and returns JSON error object" do
          new_question[:title] = nil
          patch :update, format: :json, article_id: article.slug, question: new_question, id: question.id
          expect(JSON.parse(response.body)["success"]).to eq(false)
        end
      end
    end
    describe "user IS NOT logged in" do
      it "returns a 401 unauthorized status" do
        sign_out
        patch :update, format: :json, article_id: article.slug, question: new_question, id: question.id
        expect(response).to have_http_status(401)
      end
    end

  end

  describe "DELETE #destroy" do
    describe "user is logged in" do
      before(:each) { sign_in_as(user) }

      context "Current user owns the question" do
        it "only allows the owner to destroy the question" do
          sign_out
          sign_in_as(evil_user)
          delete :destroy, format: :json, article_id: article.slug, id: question.id
          expect(response).to have_http_status(403)
        end

          
        it "destroys the question and responds JSON success" do
          id = question.id
          delete :destroy, article_id: article.slug, id: question.id
          expect {Question.find(id)}.to raise_error ActiveRecord::RecordNotFound
          expect(JSON.parse(response.body)["success"]).to eq(true)
        end
      end
    end

    describe "user IS NOT logged in" do
      it "returns a 401 unauthorized status" do
        sign_out
        delete :destroy, format: :json,  article_id: article.slug, id: question.id
        expect(response).to have_http_status(401)
      end
    end
  end
end
