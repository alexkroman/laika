class Vendor < ActiveRecord::Base
  has_select_options(:order => 'user_id ASC, public_id ASC') {|r| [ r.public_id, r.id ] }

  belongs_to :user
  attr_protected :user
  has_many :vendor_test_plans, :dependent => :destroy
  validates_presence_of :public_id

  def self.unclaimed
    find :all, :conditions => { :user_id => nil }
  end

  def editable_by?(vendor_user)
    user == vendor_user or vendor_user.administrator?
  end
end
