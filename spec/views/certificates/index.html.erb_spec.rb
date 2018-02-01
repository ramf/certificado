require 'rails_helper'

RSpec.describe "certificates/index", type: :view do
  before(:each) do
    assign(:certificates, [
      Certificate.create!(
        :name => "Name",
        :email => "Email",
        :description => "MyText"
      ),
      Certificate.create!(
        :name => "Name",
        :email => "Email",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of certificates" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
