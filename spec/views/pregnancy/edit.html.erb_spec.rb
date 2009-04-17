require File.dirname(__FILE__) + '/../../spec_helper'

describe "pregnancy/edit.html.erb" do
  it "should show the pregnancy form and checkbox" do
    assigns[:patient] = pd = stub_model(Patient)

    render "pregnancy/edit.html.erb"

    response.should have_tag("form[action=/pregnancy/update?patient_datum_id=#{pd.id}]") do
      with_tag 'input[type=checkbox][name=pregnant]'
    end
  end

  it "should show the pregnancy form and checkbox checked" do
    assigns[:patient] = pd = stub_model(Patient, :pregnant => true)

    render "pregnancy/edit.html.erb"

    response.should have_tag("form[action=/pregnancy/update?patient_datum_id=#{pd.id}]") do
      with_tag 'input[type=checkbox][name=pregnant][checked=true]'
    end
  end
end
