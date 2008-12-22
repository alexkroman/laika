require File.dirname(__FILE__) + '/../spec_helper'

describe ClinicalDocument, "can store validation reports" do
  fixtures :clinical_documents
  
  before(:each) do
    @joe = clinical_documents(:joe_c32_clinical_document)
  end
  
  it "should generate a filename for the validation report" do
    filename_regex = Regexp.new("clinical_document_report_#{@joe.id}.xml$")
    @joe.validation_report_filename.should match(filename_regex)
  end
end