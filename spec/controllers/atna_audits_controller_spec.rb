require File.dirname(__FILE__) + '/../spec_helper'

describe AtnaAuditsController do
  before do
    @user = stub :user
    controller.stub!(:current_user).and_return(@user)
  end

  describe "with no syslog database" do
    it "should set @notice" do
      get :index
      response.should be_success
      assigns[:notice].should_not be_nil
    end
  end

  describe "with an empty syslog database" do
    before do
      AtnaAudit.stub!(:paginate).and_return([])
    end

    it "should not set @notice" do
      get :index
      response.should be_success
      assigns[:notice].should be_nil
    end
  end

  describe "with an empty log entry" do
    before do
      AtnaAudit.stub!(:paginate).and_return([mock_model(AtnaAudit, :message => '')])
    end

    it "should result in a parse failure" do
      get :index
      response.should be_success
      assigns[:notice].should == 'Error: ATNA log message is not valid.'
    end
  end

  describe "with a valid log entry" do
    before do
      AtnaAudit.stub!(:paginate).and_return([mock_model(AtnaAudit, :message => <<ATNA_ENTRY)])
FIXME TODO XXX valid ATNA log entry needed
ATNA_ENTRY
    end

    it "should be tested (SF ticket 2738097)"
  end
end
