require File.dirname(__FILE__) + '/../spec_helper'

describe TestResult do
  fixtures :test_results

  describe "test result for pix feed" do
    before(:each) do
      @pix  = test_results(:pixfeed)
    end

    # XXX this doesn't test anything, it just verifies the contents of the fixture
    it "is valid" do
      @pix.patient_identifier.should == '1234567890'
      @pix.assigning_authority.should == 'CCHIT&1.2.3.4.5.6.7.8.9&ISO'
      @pix.result.should == 'PASS'
    end
  end

end
