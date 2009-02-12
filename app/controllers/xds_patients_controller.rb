class XdsPatientsController < ApplicationController
  page_title 'XDS Registry'

  def index
  end

  def create
    flash[:notice] = "This feature is not yet implemented."
    redirect_to :action => :index
  end
end
