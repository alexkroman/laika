require File.dirname(__FILE__) + '/../spec_helper'

describe Role do
  it "should return the Adminstrator role" do
    role = Role.administrator
    role.name.should == Role::ADMINISTRATOR_NAME
    Role.administrator.should == role
  end
end
