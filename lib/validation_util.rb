# Real simple utility to access the external schematron validation web service
class ValidationUtil
  
   require 'net/http'
   require 'rexml/document'
   
   def ValidationUtil.validate(docType, xml)
     puts VALIDATION_URL
     res = Net::HTTP.post_form(URI.parse(VALIDATION_URL), {'docType'=>docType, 'xmlContent'=>xml})     
     res.value
     return REXML::Document.new(res.body)   
   end
   
end