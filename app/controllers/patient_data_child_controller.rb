#
# This controller is an abstract class that provides basic CRUD operations for
# patient data sections. Individual actions can be overridden as needed.
#
class PatientDataChildController < ApplicationController
  before_filter :find_patient_data
  layout false

  def new
    instance_variable_set(instance_var_name, model_class.new)
    render :action => 'edit'
  end
  
  def create
    instance_variable_set(instance_var_name, model_class.new(params[param_key]))
    @patient_data.send(association_name) << instance_variable_get(instance_var_name)
  end

  def edit
    instance_variable_set(instance_var_name, @patient_data.send(association_name).find(params[:id]))
  end
  
  def update
    instance_variable_set(instance_var_name, @patient_data.send(association_name).find(params[:id]))
    instance_variable_get(instance_var_name).send(:update_attributes, params[param_key])
    
    render :partial => 'show', :locals => {
      :patient_data => @patient_data,
      param_key     => instance_variable_get(instance_var_name)
    }
  end

  def destroy
    instance = @patient_data.send(association_name).find(params[:id])
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

  def find_patient_data
    if params[:patient_data_instance_id]
      @patient_data = PatientData.find params[:patient_data_instance_id]
    end
    redirect_to patient_data_url unless @patient_data
  end

end
