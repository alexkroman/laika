class RegistrationInformationsController < ApplicationController
  # GET /registration_informations
  # GET /registration_informations.xml
  def index
    @registration_informations = RegistrationInformation.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @registration_informations }
    end
  end

  # GET /registration_informations/1
  # GET /registration_informations/1.xml
  def show
    @registration_information = RegistrationInformation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @registration_information }
    end
  end

  # GET /registration_informations/new
  # GET /registration_informations/new.xml
  def new
    @registration_information = RegistrationInformation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @registration_information }
    end
  end

  # GET /registration_informations/1/edit
  def edit
    @registration_information = RegistrationInformation.find(params[:id])
  end

  # POST /registration_informations
  # POST /registration_informations.xml
  def create
    @registration_information = RegistrationInformation.new(params[:registration_information])

    respond_to do |format|
      if @registration_information.save
        flash[:notice] = 'RegistrationInformation was successfully created.'
        format.html { redirect_to(@registration_information) }
        format.xml  { render :xml => @registration_information, :status => :created, :location => @registration_information }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @registration_information.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /registration_informations/1
  # PUT /registration_informations/1.xml
  def update
    @registration_information = RegistrationInformation.find(params[:id])

    respond_to do |format|
      if @registration_information.update_attributes(params[:registration_information])
        flash[:notice] = 'RegistrationInformation was successfully updated.'
        format.html { redirect_to(@registration_information) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @registration_information.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /registration_informations/1
  # DELETE /registration_informations/1.xml
  def destroy
    @registration_information = RegistrationInformation.find(params[:id])
    @registration_information.destroy

    respond_to do |format|
      format.html { redirect_to(registration_informations_url) }
      format.xml  { head :ok }
    end
  end
end
