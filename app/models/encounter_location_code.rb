class EncounterLocationCode < ActiveRecord::Base
  named_scope :all, :order => 'name ASC'

  include MatchHelper

  def validate_c32(encounter_location_code)

    unless encounter_location_code
      return [ContentError.new]
    end

    errors = []
    return errors.compact
  end

end
