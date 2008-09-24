require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users/edit.html.erb" do
  include UsersHelper
  
  before do
    @user = mock_model(User)
    @user.stub!(:first_name).and_return("MyString")
    @user.stub!(:last_name).and_return("MyString")
    @user.stub!(:email).and_return("MyString")
    @user.stub!(:company).and_return("MyString")
    @user.stub!(:company_url).and_return("MyString")
    @user.stub!(:password).and_return("MyString")
    @user.stub!(:password_confirmation).and_return("MyString")
    assigns[:user] = @user
  end

  it "should render edit form" do
    render "/users/edit.html.erb"
    
    response.should have_tag("form[action=#{user_path(@user)}][method=post]") do
      with_tag('input#user_first_name[name=?]', "user[first_name]")
      with_tag('input#user_last_name[name=?]', "user[last_name]")
      with_tag('input#user_email[name=?]', "user[email]")
      with_tag('input#user_company[name=?]', "user[company]")
      with_tag('input#user_company_url[name=?]', "user[company_url]")
      with_tag('input#user_password[name=?]', "user[password]")
      with_tag('input#user_password_confirmation[name=?]', "user[password_confirmation]")
    end
  end
end


