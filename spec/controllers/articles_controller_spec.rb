require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "GET #index" do
    before { get :index }

    it { should respond_with(200) }
  end

  describe "GET #show" do
    it { should respond_with(200) }
  end

  describe "GET #edit" do
    before { get :edit }

    it { should respond_with(200) }
  end
end
