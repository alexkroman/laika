class Comment < ActiveRecord::Base

  strip_attributes!

  belongs_to :commentable, :polymorphic => true

  include MatchHelper

  #Reimplementing from MatchHelper
  def section_name
    self.commentable_type.underscore
  end

  #Reimplementing from MatchHelper  
  def subsection_name
    'comment'
  end

  def validate_c32(name_element)

  end

  def to_c32(xml)

  end

  def randomize()
    self.text = 'Patient is very healthy'
  end

end
