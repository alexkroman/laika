require_dependency 'sort_order'

class VendorTestPlansController < ApplicationController
  page_title 'Laika Dashboard'
  include SortOrder
  self.valid_sort_fields = %w[ created_at updated_at patient_data.name kinds.name ]

  # GET /vendor_test_plans
  # GET /vendor_test_plans.xml
  def index
    respond_to do |format|
      format.html do
        @vendor_test_plans = {}
        @errors = {}
        @warnings = {}
        VendorTestPlan.find(:all, :include => [:kind, :patient], :conditions => {
          :user_id => current_user
        }, :order => sort_order || 'created_at ASC').each do |vendor_test_plan|
          (@vendor_test_plans[vendor_test_plan.vendor] ||= []) << vendor_test_plan
          if vendor_test_plan.clinical_document
            @errors[vendor_test_plan], @warnings[vendor_test_plan] = vendor_test_plan.count_errors_and_warnings
          end
        end
        @vendors = @vendor_test_plans.keys
      end
      format.xml  { render :xml => current_user.vendor_test_plans }
    end
  end

  # GET /vendor_test_plans/1
  # GET /vendor_test_plans/1.xml
  def show
    @vendor_test_plan = VendorTestPlan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vendor_test_plan }
    end
  end

  # GET /vendor_test_plans/new
  # GET /vendor_test_plans/new.xml
  def new
    @vendor_test_plan = VendorTestPlan.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vendor_test_plan }
    end
  end

  # GET /vendor_test_plans/1/edit
  def edit
    @vendor_test_plan = VendorTestPlan.find(params[:id])
  end

  # POST /vendor_test_plans
  # POST /vendor_test_plans.xml
  def create
    @vendor_test_plan = VendorTestPlan.new(params[:vendor_test_plan])

    respond_to do |format|
      if @vendor_test_plan.save
        @vendor_test_plan.test_result = TestResult.new(:result => 'IN-PROGRESS')
        flash[:notice] = 'VendorTestPlan was successfully created.'
        format.html { redirect_to(@vendor_test_plan) }
        format.xml  { render :xml => @vendor_test_plan, :status => :created, :location => @vendor_test_plan }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vendor_test_plan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vendor_test_plans/1
  # PUT /vendor_test_plans/1.xml
  def update
    @vendor_test_plan = VendorTestPlan.find(params[:id])

    respond_to do |format|
      if @vendor_test_plan.update_attributes(params[:vendor_test_plan])
        flash[:notice] = 'VendorTestPlan was successfully updated.'
        format.html { redirect_to(@vendor_test_plan) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vendor_test_plan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vendor_test_plans/1
  # DELETE /vendor_test_plans/1.xml
  def destroy
    @vendor_test_plan = VendorTestPlan.find(params[:id])
    @vendor_test_plan.destroy

    respond_to do |format|
      format.html { redirect_to(vendor_test_plans_url) }
      format.xml  { head :ok }
    end
  end

  def inspect_content
    @vendor_test_plan = VendorTestPlan.find(params[:id])
  end

  # perform the external validation and display the results
  def validate 
    @vendor_test_plan = VendorTestPlan.find(params[:id])  
  end

  def validatepix
    @vendor_test_plan = VendorTestPlan.find(params[:id])
    @patient = @vendor_test_plan.patient
  end

  def checklist 
    @vendor_test_plan = VendorTestPlan.find(params[:id])
    clinical_document = @vendor_test_plan.clinical_document
    
    @doc = clinical_document.as_xml_document(true)
    
    if @doc.root && @doc.root.name == "ClinicalDocument"
      pi = REXML::Instruction.new('xml-stylesheet', 
        'type="text/xsl" href="' + 
        relative_url_root + 
        '/schemas/generate_and_format.xsl"')
      @doc.insert_after(@doc.xml_decl, pi)
      render :xml => @doc.to_s
    else
      redirect_to clinical_document.public_filename
    end
  end
  
  def xds_query_checklist
    @vendor_test_plan = VendorTestPlan.find(params[:id])
    @metadata = @vendor_test_plan.metadata
    render :layout => false
  end
 
  def set_status
    vendor_test_plan = VendorTestPlan.find(params[:id])
    if vendor_test_plan.user == current_user
      results = vendor_test_plan.test_result || TestResult.new(:vendor_test_plan_id=>vendor_test_plan.id)
      case params["status"]
        when "pass"
          results.result="PASS"
        when "fail"
          results.result = "FAIL"
        when "inprogress"
          results.result = "IN-PROGRESS"         
      end
      results.save!
    end
    redirect_to vendor_test_plans_url
  end
  

  def validate_p_and_r
    @vendor_test_plan = VendorTestPlan.find(params[:id])
    @vendor_test_plan.validate_xds_provide_and_register
  end

end
