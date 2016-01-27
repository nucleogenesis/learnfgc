require 'rails_helper'

RSpec.describe QuestionCommentsController, type: :controller do
  let(:article) { build_stubbed :article }
  let(:question) { build_stubbed :question }
  let(:question_comment) { build_stubbed :question_comment }

  describe "GET #index" do
    it "returns http success" do
      get :index, article_id: article.id, question_id: question.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, article_id: article.id, question_id: question.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, article_id: article.id, question_id: question.id, id: question_comment.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, article_id: article.id, question_id: question.id, id: question_comment.id
      expect(response).to have_http_status(:success)
    end
  end
end
