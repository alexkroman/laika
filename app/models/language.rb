class Language < ActiveRecord::Base
  belongs_to :patient_data
  belongs_to :iso_country
  belongs_to :iso_language
  belongs_to :language_ability_mode
end
