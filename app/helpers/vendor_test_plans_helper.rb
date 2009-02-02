require_dependency 'sort_order'

module VendorTestPlansHelper

  include SortOrderHelper
  
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
end
