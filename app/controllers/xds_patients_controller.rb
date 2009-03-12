require_dependency 'sort_order'

class XdsPatientsController < ApplicationController
  page_title 'XDS Registry'

  include SortOrder
  self.valid_sort_fields = %w[ name created_at updated_at ]

  def index
    @patient_data_list = PatientData.find(:all,
      :conditions => {:vendor_test_plan_id => nil},
      :order => "name ASC")
      
    @vendors = current_user.vendors + Vendor.unclaimed

    # These session values are set by TestPlanManagerController#assign_patient_data
    # so that previous selections are retained as a convenience in the UI.
    @previous_vendor = Vendor.find_by_id(session[:previous_vendor_id]) if session[:previous_vendor_id]
  end
  
  def query
    pi = PatientIdentifier.find(params[:id])
    rsqr = XDS::RegistryStoredQueryRequest.new(XDS_REGISTRY_URLS[:register_stored_query], 
                                                {"$XDSDocumentEntryPatientId" => "'#{pi.patient_identifier}^^^#{pi.identifier_domain_identifier}'",
                                                 "$XDSDocumentEntryStatus" => "('urn:oasis:names:tc:ebxml-regrep:StatusType:Approved')"})
    metadata = rsqr.execute
    
    render :partial => 'metadata', :locals => {:metadata => metadata,:vendors => current_user.vendors + Vendor.unclaimed,:patient_identifier=>pi}
  end
  
  # Creates the form that collects data for a provide and register test
  def provide_and_register_setup
    patient_data = PatientData.find(params[:id])
    render :partial => 'provide_and_register_setup', :locals => {:patient_data => patient_data, :vendors => (current_user.vendors + Vendor.unclaimed)}
  end

  # Creates the form that collects data to actuall provide and register a document to an XDS Repository
  def provide_and_register
    patient_data = PatientData.find(params[:id])
    render :partial => 'provide_and_register', :locals => {:patient_data => patient_data}
  end
  
  def do_provide_and_register
    md = XDS::Metadata.new
    md.from_hash(params[:metadata], AFFINITY_DOMAIN_CONFIG)
    md.mime_type = 'text/xml'
    md.ss_unique_id = "1.3.6.1.4.1.21367.2009.1.2.1.#{Time.now.to_i}"
    md.source_id = "1.3.6.1.4.1.21367.2009.1.2.1"
    md.language_code = 'en-us'
    md.creation_time = Time.now.strftime('%Y%m%d')
    pd = PatientData.find(params[:pd_id])
    prdsr = XDS::ProvideAndRegisterDocumentSetBXop.new(XDS_REGISTRY_URLS[:retrieve_document_set_request],
                                                       md, pd.to_c32)
    response = prdsr.execute
    if response.success?
      flash[:notice] = "Provide and Register successful"
    else
      flash[:notice] = "Provide and Register failed #{response.errors.inspect}"
    end
    redirect_to :action => :index
  end

  def create
    flash[:notice] = "This feature is not yet implemented."
    patient_data = PatientData.find params[:patient_data_id]
    redirect_to :action => :index
  end
end
