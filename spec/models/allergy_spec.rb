require File.dirname(__FILE__) + '/../spec_helper'

describe Allergy do
  before(:each) do
    @allergy = Allergy.new
  end

  it "should be valid" do
    @allergy.should be_valid
  end
end
