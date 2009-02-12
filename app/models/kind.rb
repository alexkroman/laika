class Kind < ActiveRecord::Base
  has_select_options(:order => 'test_type ASC, name ASC') {|r| [r.display_name, r.id] }

  def display_name
    "#{test_type} #{name}"
  end
end
