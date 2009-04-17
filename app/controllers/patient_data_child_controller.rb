#
# This controller is an abstract class that provides basic CRUD operations for
# patient data sections. Individual actions can be overridden as needed.
#
class PatientDataChildController < ApplicationController
  before_filter :find_patient
  layout false

  def new
    instance_variable_set(instance_var_name, model_class.new)
    render :action => 'edit'
  end
  
  def create
    instance_variable_set(instance_var_name, model_class.new(params[param_key]))
    @patient.send(association_name) << instance_variable_get(instance_var_name)
  end

  def edit
    instance_variable_set(instance_var_name, @patient.send(association_name).find(params[:id]))
  end
  
  def update
    instance = @patient.send(association_name).find(params[:id])
    instance.send(:update_attributes, params[param_key])

    render :partial => 'show', :locals => {
      :patient => @patient,
      param_key     => instance
    }
  end

  def destroy
    instance = @patient.send(association_name).find(params[:id])
    instance.destroy
  end
  
  private
  def base_name
    @base_name ||= self.class.name.sub(/Controller$/,'')
  end

  def model_class
    @model_class ||= base_name.singularize.constantize
  end

  def association_name
    @association_name ||= base_name.underscore
  end

  def param_key
    @param_key ||= association_name.singularize.to_sym
  end

  def instance_var_name
    @instance_var_name ||= "@#{param_key}"
  end

  def find_patient
    if params[:patient_datum_id]
      @patient = Patient.find params[:patient_datum_id]
    end
    redirect_to patients_url unless @patient
  end

end
