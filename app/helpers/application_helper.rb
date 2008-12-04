# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
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


end
