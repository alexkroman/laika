# This class represents the vital sign section of a C32 Document
# Since the vital signs are exactly the same as results, the same
# database structure is used (via ActiveRecord's STI facilities)
#
# Methods in this class are overides to provide different template
# ids when validating and generating XML
class VitalSign < Result

  def section_template_id
    '2.16.840.1.113883.10.20.1.16'
  end

  # Statement CCD template id is the same as Results

  def statement_c32_template_id
    '2.16.840.1.113883.3.88.11.32.15'
  end

end