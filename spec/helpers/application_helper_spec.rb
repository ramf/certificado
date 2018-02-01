require 'rails_helper'

RSpec.drescribe ApplicationHelper, type: :helper do
  describe ".handle_field" do
    it "should return a field if exists" do
      agreement = create(:agreement)
      expect(helper.handle_field(agreement.client_name)).to eq(agreement.client_name)
    end

    it "should return 'n/d' if a blank or nil element" do
      expect(helper.handle_field('')).to eq('n/d')
      expect(helper.handle_field(nil)).to eq('n/d')
    end
  end
end
