require File.dirname(__FILE__) + '/../../spec_helper'

describe "addresses/_edit.html.erb" do
  fixtures :iso_states

  before do
    IsoCountry.stub!(:all).and_return([])
    @states = %w[
      AK AL AR AS AZ CA CO CT DC DE FL FM GA GU HI IA ID IL IN KS KY LA MA MD
      ME MH MI MN MO MS MT NC NE NJ NH NM NV NY ND OH OK OR PA PW PR RI SC SD
      TN TX UT VI VT VA WA WI WV WY
    ]
  end

  describe "with an existing address (addresses/edit)" do
    before do
      @address = Address.create!
    end

    it "should render the edit form" do
      render :partial  => 'addresses/edit', :locals => {:address => @address}
      response.should have_tag("select[id=address_state]") do
        @states.each {|state| with_tag "option", state }
      end
    end
  end

  describe "without an existing address (addresses/new)" do
    before do
      @address = Address.new
    end

    it "should render the edit form" do
      render :partial  => 'addresses/edit', :locals => {:address => @address}
      response.should have_tag("select[id=address_state]") do
        @states.each {|state| with_tag "option", state }
      end
    end
  end

end


