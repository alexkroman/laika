class VendorTestPlan < ActiveRecord::Base
  has_one :patient_data
  belongs_to :vendor
  has_one :clinical_document
  
  def validate_clinical_document_content
    results = {}
    document = REXML::Document.new(File.new(clinical_document.full_filename))
    doc_locations = DocumentLocation.find_all_by_doc_type(clinical_document.doc_type)
    doc_locations.each do |location|
      vars = location.bind_variables(patient_data)
      if vars
        result = REXML::XPath.match(document, location.xpath_expression, nil, vars)
        results[location] = result[0]
      end
    end
    
    results
  end
end
