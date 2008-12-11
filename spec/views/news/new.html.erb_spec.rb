require File.dirname(__FILE__) + '/../../spec_helper'

describe "news/new.html.erb" do

  it "should render new message form" do
    assigns[:message] = SystemMessage.new
    render "news/new.html.erb"
    response.should have_tag("form[action=/news][method=post]") do
      with_tag 'textarea#message_body[name=?]', 'message[body]'
    end
  end

end


