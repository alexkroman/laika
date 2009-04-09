class ConditionsController < PatientDataChildController
  auto_complete_for :snowmed_problem, :name
end
