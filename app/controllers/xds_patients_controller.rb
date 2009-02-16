class XdsPatientsController < ApplicationController
  page_title 'XDS Registry'

  def index
  end

  def create
    flash[:notice] = "This feature is not yet implemented."
    patient_data = PatientData.find params[:patient_data_id]
    #metadata = XDS::Metadata.new
    #service = XDS::Service.new('http://localhost:8080/axis2/services/xdsrepositoryb')
    #service.provide_and_register_document(metadata, patient_data)
    redirect_to :action => :index
  end
end
