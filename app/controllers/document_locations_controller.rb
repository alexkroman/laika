class DocumentLocationsController < ApplicationController
  # GET /document_locations
  # GET /document_locations.xml
  def index
    @document_locations = DocumentLocation.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @document_locations }
    end
  end

  # GET /document_locations/1
  # GET /document_locations/1.xml
  def show
    @document_location = DocumentLocation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @document_location }
    end
  end

  # GET /document_locations/new
  # GET /document_locations/new.xml
  def new
    @document_location = DocumentLocation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @document_location }
    end
  end

  # GET /document_locations/1/edit
  def edit
    @document_location = DocumentLocation.find(params[:id])
  end

  # POST /document_locations
  # POST /document_locations.xml
  def create
    @document_location = DocumentLocation.new(params[:document_location])

    respond_to do |format|
      if @document_location.save
        flash[:notice] = 'DocumentLocation was successfully created.'
        format.html { redirect_to(@document_location) }
        format.xml  { render :xml => @document_location, :status => :created, :location => @document_location }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @document_location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /document_locations/1
  # PUT /document_locations/1.xml
  def update
    @document_location = DocumentLocation.find(params[:id])

    respond_to do |format|
      if @document_location.update_attributes(params[:document_location])
        flash[:notice] = 'DocumentLocation was successfully updated.'
        format.html { redirect_to(@document_location) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @document_location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /document_locations/1
  # DELETE /document_locations/1.xml
  def destroy
    @document_location = DocumentLocation.find(params[:id])
    @document_location.destroy

    respond_to do |format|
      format.html { redirect_to(document_locations_url) }
      format.xml  { head :ok }
    end
  end
end
