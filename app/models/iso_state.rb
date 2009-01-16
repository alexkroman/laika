class IsoState < ActiveRecord::Base
  has_select_options(:order => 'iso_abbreviation ASC') {|r| r.iso_abbreviation }
end
