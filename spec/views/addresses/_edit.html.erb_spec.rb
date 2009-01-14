require File.dirname(__FILE__) + '/../../spec_helper'

describe "all address/_edit cases", :shared => true do

  it "should render the state dropdown with all states" do
    render :partial  => 'addresses/edit', :locals => {:address => @address}
    response.should have_tag("select[id=address_state]") do
      %w[
        AK AL AR AS AZ CA CO CT DC DE FL FM GA GU HI IA ID IL IN KS KY LA MA MD
        ME MH MI MN MO MS MT NC NE NJ NH NM NV NY ND OH OK OR PA PW PR RI SC SD
        TN TX UT VI VT VA WA WI WV WY
      ].each {|state| with_tag "option", state }
    end
  end

  it "should include an empty option in the state dropdown" do
    render :partial  => 'addresses/edit', :locals => {:address => @address}
    response.should have_tag("select[id=address_state]") do
      with_tag "option", ''
    end
  end

  it "should include an empty option in the country dropdown" do
    render :partial  => 'addresses/edit', :locals => {:address => @address}
    response.should have_tag("select[id=address_iso_country_id]") do
      with_tag "option", ''
    end
  end
end

describe "addresses/_edit.html.erb" do
  fixtures :iso_states, :iso_countries

  describe "without an existing address (addresses/new)" do
    before { @address = Address.new }
    it_should_behave_like "all address/_edit cases"
  end

  describe "with an existing address (addresses/edit)" do
    before do
      @address = Address.create!(
        :state => 'CA',
        :iso_country_id => iso_countries(:peru).id
      )
    end
    it_should_behave_like "all address/_edit cases"

    it "should have the address state selected" do
      render :partial  => 'addresses/edit', :locals => {:address => @address}
      response.should have_tag("select[id=address_state]") do
        with_tag "option[selected=selected]", 'CA'
      end
    end

    it "should have the address country selected" do
      render :partial  => 'addresses/edit', :locals => {:address => @address}
      response.should have_tag("select[id=address_iso_country_id]") do
        with_tag "option[selected=selected]", iso_countries(:peru).name
      end
    end
  end

end


