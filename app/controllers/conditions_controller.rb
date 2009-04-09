class ConditionsController < PatientDataChildController
  
  auto_complete_for :snowmed_problem, :name
  
  def destroy
    super
    render :partial  => 'delete.rjs'
  end
  
end
