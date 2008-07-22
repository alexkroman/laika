class Comment < ActiveRecord::Base
  strip_attributes!

  belongs_to :patient_data
  include PersonLike
  
  def randomize()
    self.person_name = PersonName.new
    self.person_name.first_name = Faker::Name.first_name
    self.person_name.last_name = Faker::Name.last_name
    self.text = 'Patient is very healthy'
  end
  
end
