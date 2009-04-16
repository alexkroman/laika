require_dependency 'sort_order'

class XdsPatientsController < ApplicationController
  page_title 'XDS Registry'

  include SortOrder
  self.valid_sort_fields = %w[ name created_at updated_at ]

  def index
    @patients = PatientData.find(:all,
      :conditions => {:vendor_test_plan_id => nil},
      :order => sort_order || 'name ASC')
      
    @vendors = current_user.vendors + Vendor.unclaimed

    @previous_vendor = last_selected_vendor
  end
  
  def query
    pi = PatientIdentifier.find(params[:id])
    rsqr = XDS::RegistryStoredQueryRequest.new(XDS_REGISTRY_URLS[:register_stored_query], 
                                                {"$XDSDocumentEntryPatientId" => "'#{pi.patient_identifier}^^^#{pi.identifier_domain_identifier}'",
                                                 "$XDSDocumentEntryStatus" => "('urn:oasis:names:tc:ebxml-regrep:StatusType:Approved')"})
    @metadata = rsqr.execute
    @vendors = current_user.vendors + Vendor.unclaimed
    @patient_identifier = pi
    @vendor_test_plan = VendorTestPlan.new( :user_id => current_user.id, :metadata => @metadata)
    @query = Kind.find_by_name('Query and Retrieve').id
  end
  
  # Creates the form that collects data for a provide and register test
  def provide_and_register_setup
    @patient_data = PatientData.find(params[:id])
    @vendors = current_user.vendors + Vendor.unclaimed
    @kind = Kind.find_by_name('Provide and Register').id
    @vendor_test_plan = VendorTestPlan.new(:user_id => current_user.id)
  end

  # Creates the form that collects data to actuall provide and register a document to an XDS Repository
  def provide_and_register
    @patient_data = PatientData.find(params[:id])
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
