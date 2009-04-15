# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
   def patient_data_url_for(patient_data, model, *args)
     if model.new_record? 
       send("patient_datum_#{model.class.name.tableize}_path", patient_data, *args) 
     else
       send("patient_datum_#{model.class.name.underscore}_path", patient_data, model, *args)
     end
   end

  def http_method(model)
    if model.new_record?
      'post'
    else
      'put'
    end
  end
  
  def required_field(req)
     "<td>#{(req == :r2) ? 'R2' : (req == :req) ? 'R' : 'O'}</td>"
  end

  def current_controller?(name)
    controller.controller_name == name
  end


  def print_validation_for(model, field)
    return nil unless model.respond_to?(:requirements) and model.requirements
    output = case model.requirements[field]
             when :required
        '<span class="validation_for required">Required</span>'
             when :hitsp_required
         '<span class="validation_for required">Required (HITSP R)</span>'
             when :hitsp_r2_required
         '<span class="validation_for required">Required (HITSP R2)</span>'
             when :hitsp_optional
         '<span class="validation_for">Optional (HITSP R)</span>'
             when :hitsp_r2_optional
         '<span class="validation_for">Optional (HITSP R2)</span>'
             else
         ''
             end
  end

  def javascript_include_if_exists(name, *args)
    if FileTest.exist?(File.join(RAILS_ROOT, 'public', 'javascripts', "#{name}.js"))
      javascript_include_tag(name, *args)
    end
  end


  def selected_value(select_id)
      "$('#{select_id}').options[$('#{select_id}').selectedIndex].value"
  end

end
