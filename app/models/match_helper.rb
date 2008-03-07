# Module to be included into models who do matching against clinical documents
# The match value function will pull the section and subsection names from
# the methods section_name and subsection_name. By default, section_name
# will return the underscore name of the class. Subsection will return nil.
# To change this behavior, reimplement section_name or subsection_name in
# the model class.
module MatchHelper
  def self.included(base)
    base.class_eval do
      def match_value(an_element, xpath, field, value)
        error = XmlHelper.match_value(an_element, xpath, value)
        if error
          return ContentError.new(:section => section_name, :subsection => subsection_name, :field_name => field,
                                  :error_message => error,
                                  :location=>(an_element) ? an_element.xpath : nil)
        else
          return nil
        end
      end
      
      def section_name
        
      end
      
      def subsection_name
        nil
      end
    end
  end
end