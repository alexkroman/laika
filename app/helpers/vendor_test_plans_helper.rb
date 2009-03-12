require_dependency 'sort_order'

module VendorTestPlansHelper

  include SortOrderHelper
  
  def action_area(vendor_test_plan)
    case vendor_test_plan.kind.display_name
    when 'PIX Feed'
      render :partial => 'pix_feed_action_area', :locals => {:vendor_test_plan => vendor_test_plan}
    when 'PDQ Query', 'PIX Query'
      render :partial => 'pdq_query_action_area', :locals => {:vendor_test_plan => vendor_test_plan}
    when 'C32 Generate and Format', 'C32 Display and File'
      render :partial => 'c32_action_area', :locals => {:vendor_test_plan => vendor_test_plan}
    when 'XDS Query and Retrieve'
      render :partial => 'xds_query_and_retrieve_action_area', :locals => {:vendor_test_plan => vendor_test_plan}
    when 'XDS Provide and Register'
      render :partial => 'xds_provide_and_register_action_area', :locals => {:vendor_test_plan => vendor_test_plan}
    end
  end
  
  def execution_div(vendor_test_plan)
    case vendor_test_plan.kind.display_name
    when 'C32 Generate and Format'
      render :partial => 'generate_and_format_execution_div', :locals => {:vendor_test_plan => vendor_test_plan}
    when 'PIX Feed'
      render :partial => 'pix_feed_execution_div', :locals => {:vendor_test_plan => vendor_test_plan}
    end
  end
  
  # method used to mark the elements in the document that have errors so they 
    # can be linked to
    def match_errors(errors, doc)
      error_map = {}
      error_id = 0
      @error_attributes = []
      locs = errors.collect{|e| e.location}
      locs.compact!


      locs.each do |location|
        node = REXML::XPath.first(doc ,location)
        if(node)
          elem = node
          if node.class == REXML::Attribute
            @error_attributes << node
            elem = node.element
          end
          if elem
            unless elem.attributes['error_id']
              elem.add_attribute('error_id',"#{error_id}") 
              error_id += 1
            end
            error_map[location] = elem.attributes['error_id']
          end
        end
      end

      error_map
    end
    
  def xds_metadata_single_attribute(metadata, attribute)
    "<tr>
      <td><strong>#{attribute.to_s.humanize}</strong></td>
      <td>#{metadata.send(attribute)}</td>
      <td></td>
    </tr>"
  end
  
  def xds_metadata_coded_attribute(metadata, attribute)
    "<tr>
      <td><strong>#{attribute.to_s.humanize}</strong></td>
      <td><strong>Display name</strong></td>
      <td>#{metadata.send(attribute).display_name}</td>
    </tr>
    <tr>
      <td></td>
      <td><strong>Code</strong></td>
      <td>#{metadata.send(attribute).code}</td>
    </tr>
    <tr>
      <td></td>
      <td><strong>Coding Scheme</strong></td>
      <td>#{metadata.send(attribute).coding_scheme}</td>
    </tr>
    <tr>
      <td></td>
      <td><strong>Classification Scheme</strong></td>
      <td>#{metadata.send(attribute).classification_scheme}</td>
    </tr>"
  end
  
  def vendor_test_plan_status(vtp)
    
        
      kind = vtp.kind
      case kind.test_type
        when "XDS"
          xds_test_status(vtp)
        when "C32"
          c32_test_status(vtp)
        else
          test_results_status(vtp)    
      end
      
  end
  
  
  def test_pass
    "#{image_tag("pass.png", :alt => 'Test Passed')} passed"
  end
  
  def test_fail
    "#{image_tag("fail.png", :alt => 'Test Failed')} failed"
  end
  
  def test_in_progress
     "#{image_tag("inprogress.png", :alt => 'Test In Progress')} in progress"
  end
  
  
  def xds_test_status(vtp)
    if vtp.kind.name == "Query and Retrieve"
      render :partial=>"status_area" , :locals=>{:vendor_test_plan=>vtp}
    else
      test_results_status(vtp)
    end
  end
  

  def c32_test_status(vtp)
    if vtp.kind.name == "Generate and Format"
       if vtp.clinical_document 
         vtp.content_errors.length > 0 ? test_fail : test_pass
       else
         test_in_progress
       end
    else
      render :partial=>"status_area" , :locals=>{:vendor_test_plan=>vtp}
    end
  end
  
  
  def test_results_status(vtp)
     if vtp.test_result.andand.result == "PASS"   
      test_pass
    elsif vtp.test_result.andand.result == "FAIL"
      test_fail
    else
      test_in_progress
    end  
  end
  

  
end
