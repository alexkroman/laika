require File.dirname(__FILE__) + '/../spec_helper'

describe VendorTestPlan do

  it "should count 3 warnings" do
    doc = ClinicalDocument.new
    doc.stub!(:validation_report).and_return(REXML::Document.new %[
     <Results>
     <Result validator="Content Inspection"><error /><error /></Result>
     <Result validator="UMLS CodeSystem Validator"><error /></Result>
     </Results>
    ])
    vtp = VendorTestPlan.new(:clinical_document => doc)
    vtp.stub!(:add_inspection_results_to_validation_errors)
    errors, warnings = vtp.count_errors_and_warnings
    errors.should == 0
    warnings.should == 3
  end

  it "should count 1 error" do
    doc = ClinicalDocument.new
    doc.stub!(:validation_report).and_return(REXML::Document.new %[
     <Result validator="unexpected"><error /></Result>
    ])
    vtp = VendorTestPlan.new(:clinical_document => doc)
    vtp.stub!(:add_inspection_results_to_validation_errors)
    errors, warnings = vtp.count_errors_and_warnings
    errors.should == 1
    warnings.should == 0
  end

  it "should count 2 errors and 1 warning" do
    doc = ClinicalDocument.new
    doc.stub!(:validation_report).and_return(REXML::Document.new %[
     <Results>
     <Result validator="unexpected"><error /><error /></Result>
     <Result validator="Content Inspection"><error /></Result>
     </Results>
    ])
    vtp = VendorTestPlan.new(:clinical_document => doc)
    vtp.stub!(:add_inspection_results_to_validation_errors)
    errors, warnings = vtp.count_errors_and_warnings
    errors.should == 2
    warnings.should == 1
  end

end
