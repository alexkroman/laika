class InsuranceProvider < ActiveRecord::Base
  
  strip_attributes!

  belongs_to :patient_data
  belongs_to :insurance_type
  
  has_one    :insurance_provider_patient
  has_one    :insurance_provider_subscriber
  has_one    :insurance_provider_guarantor
  
  include MatchHelper
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}
  
  def validate_c32(document)
    
  end
  
  def to_c32(xml)
   
  end
 
end
