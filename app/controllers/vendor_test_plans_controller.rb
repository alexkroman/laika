class VendorTestPlansController < ApplicationController
  
  # GET /vendor_test_plans
  # GET /vendor_test_plans.xml
  def index
    # FIXME: This is subject to request tampering and SQL injection
    @vendor_test_plans = VendorTestPlan.find(:all,
                                             :conditions => "user_id = " + self.current_user.id.to_s,
                                             :order      => "vendor_id")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vendor_test_plans }
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
  
  
  # perform the external validation and display the results
  def validate 
      inspect_content
      clinical_document = @vendor_test_plan.clinical_document  
      xml = ""
      xmlc = ""
      File.open(clinical_document.full_filename) do |f|
          xmlc =  f.read()
      end 

      @doc = REXML::Document.new xmlc
      @report =@vendor_test_plan.clinical_document.validation_report(:xml)
      @error_mapping = match_errors(@report,@doc)
      # add_inspection_results_to_validation_errors(@report,@results)
   end
   
   
   private 
   # method used to mark the elements in the document that have errors so they 
   # can be linked to
   def match_errors(errors, doc)
       error_map = {}
       error_id = 0
       @error_attributes = []
       locs = @results.collect{|res| res.location}
       locs.compact!
       REXML::XPath.each(errors,'//@location') do |e| locs << e.value end
       puts locs
       locs.each do |location|
           puts location
        node = REXML::XPath.first(doc ,location)
       # puts "#{node.inspect} #{location}"
          if(node)
             elem = node
              if node.class == REXML::Attribute
                  @error_attributes << node
              elem = node.element
             # if element
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
  
   
   def add_inspection_results_to_validation_errors(val_errors, inspection_results)
      el = val_errors.root.add_element "Result",{"isValid"=>inspection_results.length == 0,
          'validator'=>'Content Inspection'}
      
      inspection_results.each do |err|
         err_el = el.add_element "error" 
         err_el.text = %{ Section: #{err.section} 
                          Subsection: #{err.subsection}
                          Field Name: #{err.field_name}
                          Error Message: #{err. error_message}
         }
         if err.location
             err_el.add_attribute "location", err.location
         end
      end
   end
end
