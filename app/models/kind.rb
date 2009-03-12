class Kind < ActiveRecord::Base
  has_select_options(:method_name => 'dashboard_options', :label_column => :display_name,
                     :order => 'test_type ASC, name ASC',  :conditions => {:test_type => ['C32', 'PIX', 'PDQ']})
  has_select_options(:method_name => 'xds_options', :label_column => :display_name,
                     :conditions => {:test_type => 'XDS'}, :order => 'test_type ASC, name ASC')

  def display_name
    "#{test_type} #{name}"
  end
end
