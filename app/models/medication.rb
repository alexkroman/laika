class Medication < ActiveRecord::Base
  belongs_to :patient_data
  @@default_namespaces = {"cda"=>"urn:hl7-org:v3"}
  
  
  def validate_c32(xml)
     context = REXML::XPath.first(xml,"//cda:section[./cda:templateId[@root eq '2.16.840.1.113883.10.20.1.8']]",@@default_namespaces )
     # IF there is an entry for this medication then there will be a substanceAdministration element
     # that contains a consumable that contains a manufacturedProduct that has a code with the original text 
     # equal to the name of the generic medication
     # the consumeable/manfucaturedProduct/code/originalText is a required field if the substanceAdministration entry is there
     substanceAdministration = REXML::XPath.first(context,"./cda:entry/cda:substanceAdministration[ ./cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial/cda:code/cda:originalText/text() = $original]",@@default_namespaces,{"original"=>product_coded_display_name} )
     
     if substanceAdministration then    
         #consumable product
         consumable = REXML::XPath.first(substanceAdministration,"./cda:consumable",@@default_namespaces)
         manufactured = REXML::XPath.first(consumable,"./cda:manufacturedProduct",@@default_namespaces)
         code = REXML::XPath.first(manufactured,"./cda:manufacturedMaterial/cda:code",@@default_namespaces)
         translation = REXML::XPath.first(code,"cda:translation",@@default_namespaces)
        
         brand_error =  XmlHelper.match_value(manufactured,"cda:manufacturedMaterial/cda:name/text()",free_text_brand_name,@@default_namespaces)
         
         unless brand_error.nil?
	         ce = ContentError.new(:section=>"Medication", 
	                               :subsection=>"manufacturedContent",
	                               :field_name=>"name",
	                               :error_message=>brand_error,
	                               :vendor_test_plan=>patient_data.vendor_test_plan)
	          ce.save                 
	            
        end 
         
         
         med_type_error = XmlHelper.match_value(substanceAdministration,
                     "cda:entryRelationship[@typeCode='SUBJ']/cda:observation[cda:templateId/@root='2.16.840.1.113883.3.88.11.32.10']/cda:code/@displayName",medication_type,
                     @@default_namespaces)
                     
        unless med_type_error.nil?
           ce = ContentError.new(:section=>"Medication", 
                                 :subsection=>"medication_type",
                                 :field_name=>"display_name",
                                 :error_message=>med_type_error,
                                 :vendor_test_plan=>patient_data.vendor_test_plan)
                 ce.save                 
                                     
            end                      
                     
         med_status_error = XmlHelper.match_value(substanceAdministration,
             "cda:entryRelationship[@typeCode='REFR']/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.47']/cda:value/@code",status,
             @@default_namespaces)
             
             unless med_status_error.nil?
                ce = ContentError.new(:section=>"Medication", 
                                      :subsection=>"medication_status",
                                      :field_name=>"code",
                                      :error_message=>med_status_error,
                                      :vendor_test_plan=>patient_data.vendor_test_plan)
                      ce.save                 
                                          
                 end 
             
         order = REXML::XPath.first(substanceAdministration,
             "cda:entryRelationship[@typeCode='REFR']/cda:supply[moodCode='INT']",
             @@default_namespaces)
         unless order.nil?
	         order_error XmlHelper.match_value(order,
	                 "cda:supply/cda:quantity/@value",
	                  quantity_ordered_value,
	                  @@default_namespaces)       
	                         
	                  unless order_error.nil?
	                     ce = ContentError.new(:section=>"Medication", 
	                                           :subsection=>"Order",
	                                           :field_name=>"quantity",
	                                           :error_message=>order_error,
	                                           :vendor_test_plan=>patient_data.vendor_test_plan)
	                           ce.save                 
	                                               
	                      end 
         end                 
     
     else
         ce = ContentError.new(:section=>"Medication", 
                               :subsection=>"substanceAdministration",
                               :field_name=>"",
                               :error_message=>"A substanceAdministration section does not exist for the medication",
                               :vendor_test_plan=>patient_data.vendor_test_plan)
         ce.save
                               
         
        # could not find the entry so lets report the error 
     end   
     
     

   

  end
  
end


