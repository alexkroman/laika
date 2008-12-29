module Validators
   module Umls
    #Base class that sets the connection information for all of the other  UMLS models to use
    class UmlsBase < ActiveRecord::Base
        self.abstract_class = true
        establish_connection("umls_#{RAILS_ENV}")     
    end
    
    class UmlsCodeHierarchy < UmlsBase
        set_table_name "MRHIER"
    end
    
    class UmlsCodeSystem < UmlsBase
        set_table_name :MRSAB
        set_primary_key :VSAB


        def get_children
           UmlsConcept.find(:all, :conditions=>["sab = ? ",self.RSAB ],:order=>"aui") 
        end
    end

    class UmlsConcept < UmlsBase
      set_table_name :MRCONSO
      set_primary_key :AUI

       def get_children
        concepts = []
        UmlsCodeHierarchy.find(:all, :conditions=>["AUI=?",self.AUI]).each do |hier|
            concepts << UmlsConcept.find_by_sql("Select * from MRCONSO conso,(select aui from MRHIER where PTR like '#{hier.PTR}.#{self.AUI}.%') hier where hier.AUI=conso.AUI ")
        end
        concepts
      end

      def hierarchy_entries
          UmlsCodeHierarchy.find(:all, :conditions=>["AUI=?",self.AUI])
      end
    end

    # Class that validates documents against codes and codesystems in the UMLS database
    class UmlsValidator
        # The mapping file maps the oid's that would be found in a clinical document to the logical codesystem 
        # identifier in the UMLS db
        UMLS_MAPPING_DEFAULT = "config/UMLS_MAPPING_FILE.yaml"

        attr_accessor :mapping
        
        include Singleton

        def initialize
         @mapping = YAML.load_file(UMLS_MAPPING_DEFAULT)    
        end   

        def validate(document)
       
         errors = []
         
         document.elements.to_a("//*[@codeSystem]").each do |el|
           oid = el.attributes["codeSystem"]
           code = el.attributes["code"] 
           name = el.attributes["name"]
           map = @mapping[oid]        
            
           if map && code 
              cs = map["codesystem"]
              parent = map["umlscode"]
              valid = true
              if parent
                 valid = in_code_system_with_parent(cs,parent,code) 
              else
                # valid = in_code_system(cs,code)
              end              
              unless valid
                 errors << el
              end          
           end       
         end   
         errors     
        end


    private 
         # look for an entry in the UMLS db that corrisponds to the maping, if there is one, in the mapping table
         # if the mapping exists check UMLS to see if it is present.
         def get_code_system(oid)
            code_system = @mapping[oid]
            if(code_system.nil?)
            else
            sab = code_system["codesystem"]
            concept = code_system["umlscode"]
            if concept.nil?    
              return UmlsCodeSystem.find_by_RSAB(sab)
            else
              return UmlsConcept.find_by_SAB_and_CODE(sab,concept) 
            end
            end
        end
        
      
        def in_code_system( code_system,  code,  name = nil)
             params = {:sab=>code_system, :code=>code}
             params[:name ] = name if name            
             UmlsConcept.count(:conditions=>params) > 0 
        end
        
        def in_code_system_with_parent( code_system,  parent_code,  code, name = nil)
            params = {:sab=>code_system, :code=>code}
            params[:name ] = name if name
            parent_auis = UmlsConcept.find(:all,:conditions=>["sab = ? and code = ?",code_system,parent_code]).collect{|x| x.AUI }
            child_auis =  UmlsConcept.find(:all,:conditions=>params).collect{|x| x.AUI }

            UmlsCodeHierarchy.find(:all,:conditions=>["aui in (?)", parent_auis]) .each do |hier|
                like = "#{hier.PTR}.#{hier.AUI}"
                count = UmlsCodeHierarchy.count(:conditions=>["(ptr LIKE ? or ptr LIKE ?) and aui in (?)",like,"#{like}.%", child_auis])
                if count > 0 
                   return true
                end
            end
            return false
        end
    end

   end
  
end



