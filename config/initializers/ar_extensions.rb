require_dependency 'has_select_options'
require_dependency 'has_c32_component'
class ActiveRecord::Base
  extend HasSelectOptionsExtension
  extend HasC32ComponentExtension
end


