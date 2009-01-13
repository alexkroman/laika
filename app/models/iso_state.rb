class IsoState < ActiveRecord::Base
  named_scope :all, :order => 'iso_abbreviation ASC' do
    def abbreviations
      map {|s| s.iso_abbreviation }
    end
  end
end
