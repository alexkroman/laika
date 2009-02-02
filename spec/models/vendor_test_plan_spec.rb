require File.dirname(__FILE__) + '/../spec_helper'
require "lib/validators/c32_validator"
 # this will add the validate_c32 

describe VendorTestPlan do

  it "should count 3 warnings" do
    doc = ClinicalDocument.new
    content_errors = [ContentError.new(:validator=>"",:msg_type=>"warning"),
                      ContentError.new(:validator=>"",:msg_type=>"warning"),
                      ContentError.new(:validator=>"",:msg_type=>"warning")]
    vtp = VendorTestPlan.new(:clinical_document => doc,:content_errors=>content_errors)
    vtp.save
    errors, warnings = vtp.count_errors_and_warnings
    errors.should == 0
    warnings.should == 3
  end

  it "should count 1 error" do
    doc = ClinicalDocument.new
    content_errors = [ContentError.new(:validator=>"",:msg_type=>"error")]
    vtp = VendorTestPlan.new(:clinical_document => doc,:content_errors=>content_errors)
    vtp.save
    errors, warnings = vtp.count_errors_and_warnings
    errors.should == 1
    warnings.should == 0
  end

  it "should count 2 errors and 1 warning" do
    doc = ClinicalDocument.new
    content_errors = [ContentError.new(:validator=>"",:msg_type=>"error"),
                      ContentError.new(:validator=>"",:msg_type=>"error"),
                      ContentError.new(:validator=>"",:msg_type=>"warning")]
    vtp = VendorTestPlan.new(:clinical_document => doc,:content_errors=>content_errors)
    vtp.save
    
    errors, warnings = vtp.count_errors_and_warnings
    puts vtp.content_errors
    errors.should == 2
    warnings.should == 1
  end

end
