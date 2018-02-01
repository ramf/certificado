require 'rails_helper'

RSpec.describe "certificates/edit", type: :view do
  before(:each) do
    @certificate = assign(:certificate, Certificate.create!(
      :name => "MyString",
      :email => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit certificate form" do
    render

    assert_select "form[action=?][method=?]", certificate_path(@certificate), "post" do

      assert_select "input[name=?]", "certificate[name]"

      assert_select "input[name=?]", "certificate[email]"

      assert_select "textarea[name=?]", "certificate[description]"
    end
  end
end
