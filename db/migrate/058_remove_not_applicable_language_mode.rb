class RemoveNotApplicableLanguageMode < ActiveRecord::Migration
  
  def self.up
    notApplicable = LanguageAbilityMode.find_by_name('n/a')
    notApplicable.destroy
  end

  def self.down
    notApplicable = LanguageAbililityMode.new(
      :name => 'n/a'  
    )
    notApplicable.save!
  end
end
