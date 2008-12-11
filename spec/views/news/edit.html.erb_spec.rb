require File.dirname(__FILE__) + '/../../spec_helper'

describe "news/edit.html.erb" do

  it "should render new message form" do
    assigns[:message] = SystemMessage.new
    assigns[:message].id = 123
    render "news/edit.html.erb"
    response.should have_tag("form[action=#{news_url(123)}][method=post]") do
      with_tag 'textarea#message_body[name=?]', 'message[body]'
    end
  end

end


