class VendorTestPlansController < ApplicationController
  page_title 'Laika Dashboard'

  # GET /vendor_test_plans
  # GET /vendor_test_plans.xml
  def index
    vendor_test_plans = current_user.vendor_test_plans

    respond_to do |format|
      format.html do
        @vendor_test_plans = {}
        @errors = {}
        @warnings = {}
        vendor_test_plans.each do |vendor_test_plan|
          (@vendor_test_plans[vendor_test_plan.vendor] ||= []) << vendor_test_plan
          if vendor_test_plan.validated?
            @errors[vendor_test_plan], @warnings[vendor_test_plan] = vendor_test_plan.count_errors_and_warnings
          end
        end
        @vendors = @vendor_test_plans.keys
      end
      format.xml  { render :xml => vendor_test_plans }
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
    @results = @vendor_test_plan.validate_clinical_document_content
  end

  def revalidate
    begin
      @vendor_test_plan.cache_validation_report
    rescue
      flash[:notice] = "An error occurred while validating the document"
    end  
    redirect_to vendor_test_plans_url 
  end
  
  # perform the external validation and display the results
  def validate 
    @vendor_test_plan = VendorTestPlan.find(params[:id])
    clinical_document = @vendor_test_plan.clinical_document
    xmlc = ""

    File.open(clinical_document.full_filename) do |f|
      xmlc =  f.read()
    end

    begin
      @doc = REXML::Document.new xmlc
      if @vendor_test_plan.validated?
        @report = @vendor_test_plan.clinical_document.validation_report(:xml)
      else
        @vendor_test_plan.validate_clinical_document_content
        @report = REXML::Document.new "<ValidationResults/>"
      end
    rescue
      @report = REXML::Document.new "<ValidationResults><Result validator='C32 Schematron Validator' isValid='false'><error>Catastrophic data error.  Non-parseable XML uploaded to Laika</error></Result><Result validator='CCD Schematron Validator' isValid='true'/><Result validator='C32 Schema Validator' isValid='true'/></ValidationResults>"
    end

    @vendor_test_plan.add_inspection_results_to_validation_errors(@report)
    @error_mapping = match_errors(@report,@doc)
  end

  # perform the external validation and display the results
  def checklist 
    @vendor_test_plan = VendorTestPlan.find(params[:id])
    clinical_document = @vendor_test_plan.clinical_document
    test = ""

    File.open(clinical_document.full_filename, "r+") do |f|
      while input = f.gets
        if input =~ /\<\?xml\-stylesheet.*\?\>/
          if $' =~ /\n/
            test << $` + $'
          end
        else
          test << input
        end 	 		
      end
    end

    f = File.open(clinical_document.full_filename, "w+") do |f|
      f.write test
    end

    xmlc = ""
    File.open(clinical_document.full_filename) do |f|
      xmlc =  f.read()
    end 

    @doc = REXML::Document.new xmlc
    pi = REXML::Instruction.new('xml-stylesheet', 
      'type="text/xsl" href="' + 
      relative_url_root + 
      '/schemas/generate_and_format.xsl"')
    @doc.insert_after(@doc.xml_decl, pi)

    respond_to do |format|
      format.xml  { render :text => @doc.to_s}
    end
  end   
   
  private 
  # method used to mark the elements in the document that have errors so they 
  # can be linked to
  def match_errors(errors, doc)
    error_map = {}
    error_id = 0
    @error_attributes = []
    locs = []

    REXML::XPath.each(errors,'//@location') do |e| 
      locs << e.value 
    end

    locs.each do |location|
      node = REXML::XPath.first(doc ,location)
      if(node)
        elem = node
        if node.class == REXML::Attribute
          @error_attributes << node
          elem = node.element
        end
        if elem
          unless elem.attributes['error_id']
            elem.add_attribute('error_id',"#{error_id}") 
            error_id += 1
          end
          error_map[location] = elem.attributes['error_id']
        end
      end
    end

    error_map
  end  
  
end
