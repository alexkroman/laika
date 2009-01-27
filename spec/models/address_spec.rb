require File.dirname(__FILE__) + '/../spec_helper'

describe Address, "can create a instance with random values" do
  fixtures :zip_codes, :iso_countries
  
  it 'should populate values' do
    address = Address.new
    address.randomize
    address.street_address_line_one.should_not be_blank
    address.city.should_not be_blank
    address.state.should_not be_blank
    address.postal_code.should_not be_blank
    address.iso_country.should == iso_countries(:usa)
  end
end
