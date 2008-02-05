class VendorTestPlansController < ApplicationController
  
  # GET /vendor_test_plans
  # GET /vendor_test_plans.xml
  def index
    @vendor_test_plans = VendorTestPlan.find(:all)

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
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    
    puts "id " + params[:id]
    @vendor_test_plan = VendorTestPlan.find(params[:id])
    puts "Yoyo"
    @vendor_test_plan.destroy
    puts "poo"

    respond_to do |format|
      format.html { redirect_to(vendor_test_plans_url) }
      format.xml  { head :ok }
    end
  end
  
  def inspect_content
    @vendor_test_plan = VendorTestPlan.find(params[:id])
    @results = @vendor_test_plan.validate_clinical_document_content
  end
  
end
