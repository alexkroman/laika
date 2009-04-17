class ConditionsController < PatientChildController
  auto_complete_for :snowmed_problem, :name
end
