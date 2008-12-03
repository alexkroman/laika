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
end
