class TestPlanManagerController < ApplicationController

  def assign_patient_data

    copied_patient_data = PatientData.find(params[:pd_id]).copy

    # find the associated meta-data
    vendor = Vendor.find(params[:vendor_id])
    kind = Kind.find(params[:kind_id])
    user = current_user.administrator? ? User.find(params[:user_id]) : current_user

    vtp = VendorTestPlan.new(:vendor => vendor, :kind => kind, :user => user)
    vtp.save!

    copied_patient_data.vendor_test_plan = vtp
    copied_patient_data.save!

    redirect_to vendor_test_plans_url

  end

  def reassign_patient_data

    copied_patient_data = PatientData.find(params[:pd_id]).copy
    vtp_new = VendorTestPlan.find(params[:vtp_id])

    vtp_new.destroy
    # find the associated meta-data
    vendor = Vendor.find(params[:v_id])
    kind = Kind.find(params[:k_id])
    user = User.find(params[:user_id])   
    vtp = VendorTestPlan.new(:vendor => vendor, :kind => kind, :user => user)
    vtp.save!

    copied_patient_data.vendor_test_plan = vtp
    copied_patient_data.save!

    redirect_to vendor_test_plans_url

  end

  def export

    @vendor_test_plans = self.current_user.vendor_test_plans
    @users = User.find(:all)
    @vendors = Vendor.find(:all)
    @kinds = Kind.find(:all)

    File.open("#{RAILS_ROOT}/public/report.csv", "w") do |f|
      for user in @users
        flag1 = 0
        for vendor in @vendors
          flag2 = 0
          for vendor_test_plan in @vendor_test_plans
            if vendor_test_plan.user_id == user.id	  				
              if vendor_test_plan.vendor_id == vendor.id
                if flag1 == 0
                  f.write user.first_name + " " + user.last_name + "'s Inspections:\n"
                  flag1 = 1
                end	
                if flag2 == 0
                  f.write "Vendor ID:,"
                  f.write vendor.public_id + "\n\n"	
                  flag2 = 1
                end	
                f.write "Patient Name:,"
                f.write vendor_test_plan.patient_data.name + "\n" 	
                for kind in @kinds
                  if kind.id == vendor_test_plan.kind_id
                    f.write "Inspection Type:,"
                    f.write kind.name + "\n"
                    break
                  end
                end
                f.write "Result:,"
                error_count = 0
                if vendor_test_plan.validated?
                  error_count = REXML::XPath.first(vendor_test_plan.clinical_document.validation_report(:xml),"count(//error)")
                  error_count += vendor_test_plan.content_errors.length	        	          
                  if error_count > 0
                    f.write "failure\n"
                    f.write "Number of errors:, "
                    f.write error_count 
                    f.write "\n"
                  else
                    f.write "success\n"
                    f.write "Number of errors:, --\n"
                  end
                else
                  f.write "in progress\n"
                  f.write "Number of errors:, --\n"		  				
                end
                f.write "Last Modified:,"
                f.write vendor_test_plan.updated_at.strftime("%d.%b.%Y")
                f.write "\n\n"
              end
            end
          end
        end
      end
    end

    redirect_to relative_url_root + "/report.csv"

  end

end
