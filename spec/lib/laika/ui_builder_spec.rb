require File.dirname(__FILE__) + '/../../spec_helper'

describe Laika::UIBuilder::View, 'can create fields for a model' do
  fixtures :registration_information, :person_names, :genders
  
  before(:each) do
    @ri = registration_information(:joe_smith)
  end
  
  it "should create fields for properties" do
    v = Laika::UIBuilder::View.new(@ri)
    v.add_field(:date_of_birth)
    v.fields.should have(1).field
    v.fields[0].label.should == 'Date of birth'
    v.fields[0].value.should == @ri.date_of_birth
    v.fields[0].subobject.should be_false
  end
  
  it "should create fields for subproperties" do
    v = Laika::UIBuilder::View.new(@ri)
    v.add_field(:gender)
    v.fields.should have(1).field
    v.fields[0].label.should == 'Gender'
    v.fields[0].value.should == @ri.gender.name
    v.fields[0].subobject.should be_false
  end
  
  it "should create fields for subobjects" do
    v = Laika::UIBuilder::View.new(@ri)
    v.add_field(:person_name, :subattribute => :first_name)
    v.fields.should have(1).field
    v.fields[0].label.should == 'First name'
    v.fields[0].value.should == @ri.person_name.first_name
    v.fields[0].subobject.should be_true
  end
end