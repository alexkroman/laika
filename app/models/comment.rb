class Comment < ActiveRecord::Base

  strip_attributes!

  belongs_to :commentable, :polymorphic => true

  

  def to_c32(xml)

  end

  def randomize()
    self.text = 'Patient is very healthy'
  end

end
