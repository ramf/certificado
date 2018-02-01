require 'rails_helper'

RSpec.describe "certificates/new", type: :view do
  before(:each) do
    assign(:certificate, Certificate.new(
      :name => "MyString",
      :email => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new certificate form" do
    render

    assert_select "form[action=?][method=?]", certificates_path, "post" do

      assert_select "input[name=?]", "certificate[name]"

      assert_select "input[name=?]", "certificate[email]"

      assert_select "textarea[name=?]", "certificate[description]"
    end
  end
end
