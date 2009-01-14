class IsoCountry < ActiveRecord::Base
  named_scope :all, :order => 'name ASC' do
    def dropdown_items
      [ ['', ''] ] + collect{|c| [c.name, c.id]}
    end
  end
end
