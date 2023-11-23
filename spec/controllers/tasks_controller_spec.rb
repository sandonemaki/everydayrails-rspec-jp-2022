require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @project = FactoryBot.create(:project, owner: @user)
    @task = @project.tasks.create!(name: "Test Task")
  end

  describe "#show" do
    it "正常にレスポンスを返すこと" do
      sign_in @user
      get :show, format: :json, params: { project_id: @project.id, id: @task.id }
      expect(response.content_type).to include "application/json"
    end
  end

end
