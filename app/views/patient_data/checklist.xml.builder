xml.instruct!
xml.instruct! "xml-stylesheet", :type => "text/xsl", :href => ActionController::AbstractRequest.relative_url_root + "/schemas/file_and_display.xsl"
return @patient_data.to_c32(xml)