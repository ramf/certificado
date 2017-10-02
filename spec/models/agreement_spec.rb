require 'rails_helper'

RSpec.describe Agreement, type: :model do
  context "Should Respond" do
    it { should respond_to(:client_name) }
    it { should respond_to(:description) }
  end
  context "Validations" do
    it { should validate_presence_of(:client_name) }
    it { should validate_presence_of(:description) }
  end
end
