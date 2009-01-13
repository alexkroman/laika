class AdvanceDirectiveStatusCode < ActiveRecord::Base  
  named_scope :all, :order => 'name ASC'

  include MatchHelper

  def validate_c32()
  
  end 

end
