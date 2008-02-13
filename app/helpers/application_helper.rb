# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def http_method(model)
    if model.new_record?
      'post'
    else
      'put'
    end
  end
end
