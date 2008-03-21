xml.instruct!
xml.instruct! "xml-stylesheet", :type => "text/xsl", :href => ActionController::AbstractRequest.relative_url_root + "/schemas/hl7_ccd.xsl"
return @patient_data.to_c32(xml)