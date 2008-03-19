class InsuranceProviderPatient < ActiveRecord::Base
  
  strip_attributes!

  belongs_to :insurance_provider
  include PersonLike

  include MatchHelper
  
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}
  
  def validate_c32(document)
    
  end
  
  def to_c32(xml)
   
  end
 
end
