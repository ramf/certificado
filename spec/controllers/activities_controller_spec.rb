require 'rails_helper'

RSpec.describe ActivitiesController, type: :controller do

  describe "GET #activities" do
    it "returns http success" do
      get :activities
      expect(response).to have_http_status(:success)
    end
  end

end
