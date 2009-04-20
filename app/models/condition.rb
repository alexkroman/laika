class Condition < ActiveRecord::Base

  strip_attributes!

  belongs_to :problem_type

  include PatientChild
  include Commentable

  def requirements
    {
      :start_event => :hitsp_r2_optional,
      :end_event => :hitsp_r2_optional,
      :problem_type_id => :hitsp_r2_required,
      :snowmed_problem => :required,
    }
  end


 
  def to_c32(xml)
    xml.entry do
      xml.act("classCode" => "ACT", "moodCode" => "EVN") do
        xml.templateId("root" => "2.16.840.1.113883.10.20.1.27", "assigningAuthorityName" => "CCD")
        xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.7", "assigningAuthorityName" => "HITSP/C32")
        xml.id
        xml.code("nullFlavor"=>"NA")
        if start_event != nil || end_event != nil
          xml.effectiveTime do
            if start_event != nil 
              xml.low("value" => start_event.strftime("%Y%m%d"))
            end
            if end_event != nil
              xml.high("value" => end_event.strftime("%Y%m%d"))
            else
              xml.high("nullFlavor" => "UNK")
            end
          end
        end
        xml.entryRelationship("typeCode" => "SUBJ") do
          xml.observation("classCode" => "OBS", "moodCode" => "EVN") do
            xml.templateId("root" => "2.16.840.1.113883.10.20.1.28", "assigningAuthorityName" => "CCD")
            if problem_type
              xml.code("code" => problem_type.code, 
                       "displayName" => problem_type.name, 
                       "codeSystem" => "2.16.840.1.113883.6.96", 
                       "codeSystemName" => "SNOMED CT")
            end 
            xml.text do
              xml.reference("value" => "#problem-"+id.to_s)
            end
            xml.statusCode("code" => "completed")
            # only write out the coded value if the name of the condition is in the SNOMED list
            if free_text_name
              snowmed_problem = SnowmedProblem.find(:first, :conditions => {:name => free_text_name})
              if snowmed_problem
                xml.value("xsi:type" => "CD", 
                        "code" => snowmed_problem.code, 
                        "displayName" => free_text_name,
                        "codeSystem" => "2.16.840.1.113883.6.96",
                        "codeSystemName" => 'SNOMED CT')
              end
            end
          end
        end
      end
    end
  end

  def randomize(birth_date)
    self.start_event = DateTime.new(birth_date.year + rand(DateTime.now.year - birth_date.year), rand(12) + 1, rand(28) +1)
    self.problem_type = ProblemType.find(:all).sort_by{rand}.first
    self.free_text_name = SnowmedProblem.find(:all).sort_by{rand}.first.name
  end



  def self.c32_component(conditions, xml)
    if conditions.size > 0
      xml.component do
        xml.section do
          xml.templateId("root" => "2.16.840.1.113883.10.20.1.11",
                         "assigningAuthorityName" => "CCD")
          xml.code("code" => "11450-4",
                   "displayName" => "Problems",
                   "codeSystem" => "2.16.840.1.113883.6.1",
                   "codeSystemName" => "LOINC")
          xml.title "Conditions or Problems"
          xml.text do
            xml.table("border" => "1", "width" => "100%") do
              xml.thead do
                xml.tr do
                  xml.th "Problem Name"
                  xml.th "Problem Type"
                  xml.th "Problem Date"
                end
              end
              xml.tbody do
               conditions.andand.each do |condition|
                  xml.tr do
                    if condition.free_text_name != nil
                      xml.td do
                        xml.content(condition.free_text_name, 
                                     "ID" => "problem-"+condition.id.to_s)
                      end
                    else
                      xml.td
                    end 
                    if condition.problem_type != nil
                      xml.td condition.problem_type.name
                    else
                      xml.td
                    end  
                    if condition.start_event != nil
                      xml.td condition.start_event.strftime("%Y%m%d")
                    else
                      xml.td
                    end
                  end
                end
              end
            end
          end

          # XML content inspection
          yield

        end
      end
    end
  end
end
