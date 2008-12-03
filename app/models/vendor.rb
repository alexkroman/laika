class Vendor < ActiveRecord::Base
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
