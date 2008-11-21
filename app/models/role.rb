class Role < ActiveRecord::Base
  ADMINISTRATOR_NAME = 'Administrator'
  def self.administrator
    find_by_name(ADMINISTRATOR_NAME) || create(:name => ADMINISTRATOR_NAME)
  end

end
