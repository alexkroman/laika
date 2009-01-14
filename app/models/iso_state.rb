class IsoState < ActiveRecord::Base
  named_scope :all, :order => 'iso_abbreviation ASC' do
    def dropdown_items
      [ '' ] + map {|s| s.iso_abbreviation }
    end
  end
end
