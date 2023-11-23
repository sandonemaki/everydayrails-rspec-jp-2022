require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe "#index" do

    context "認証済みユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
      end

      context "有効な属性値の場合" do
        it "プロジェクトを追加できること" do
          project_params = FactoryBot.attributes_for(:project)
          sign_in @user
          expect {
            post :create, params: { project: project_params }
          }.to change(@user.projects, :count).by(1)
        end
      end

      context "無効な属性値の場合" do
        it "プロジェクトを追加できないこと" do
          project_params = FactoryBot.attributes_for(:project, :invalid)
          sign_in @user
          expect {
            post :create, params: { project: project_params }
          }.to_not change(@user.projects, :count)
        end
      end

      it "正常にレスポンスを返すこと" do
        sign_in @user
        get :index
        expect(response).to be_successful
      end

      it "200レスポンスを返すこと" do
        sign_in @user
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context "ゲストとして" do
      it "302レスポンスを返すこと" do
        get :index
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトすること" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "#show" do
      context "認可されたユーザーとして" do
        before do
          @user = FactoryBot.create(:user)
          @project = FactoryBot.create(:project, owner: @user)
        end

        it "正常にレスポンスを返すこと" do
          sign_in @user
          get :show, params: { id: @project.id }
          expect(response).to be_successful
        end
      end

      context "認可されていないユーザーとして" do
        before do
          @user = FactoryBot.create(:user)
          other_user = FactoryBot.create(:user)
          @project = FactoryBot.create(:project, owner: other_user)
        end
        
        it "ダッシュボードにリダイレクトすること" do
          sign_in @user
          get :show, params: { id: @project.id }
          expect(response).to redirect_to root_path
        end
      end
    end
  end
end
