class TestPlanManagerController < ApplicationController
  def assign_patient_data

    copied_patient_data = PatientData.find(params[:pd_id]).copy

    # find the associated meta-data
    vendor = Vendor.find(params[:vendor_id])
    kind = Kind.find(params[:kind_id])
    user = current_user.administrator? ? User.find(params[:user_id]) : current_user

    # save the vendor/kind selections in the session for next time
    session[:previous_vendor_id] = params[:vendor_id]
    session[:previous_kind_id] = params[:kind_id]

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

    report = ""

    @users.each do |user|
      flag1 = 0
      @vendors.each do |vendor|
        flag2 = 0
        @vendor_test_plans.each do |vendor_test_plan|
          if vendor_test_plan.user_id == user.id	  				
            if vendor_test_plan.vendor_id == vendor.id
              if flag1 == 0
                report << user.first_name + " " + user.last_name + "'s Inspections:\n"
                flag1 = 1
              end	
              if flag2 == 0
                report << "Vendor ID:,"
                report << vendor.public_id + "\n\n"	
                flag2 = 1
              end	
              report << "Patient Name:,"
              report << vendor_test_plan.patient_data.name + "\n" 	
              @kinds.each do |kind|
                if kind.id == vendor_test_plan.kind_id
                  report << "Inspection Type:,"
                  report << kind.name + "\n"
                  break
                end
              end
              report << "Result:,"
              error_count = 0
              if vendor_test_plan.validated?
                error_count = REXML::XPath.first(vendor_test_plan.clinical_document.validation_report(:xml),"count(//error)")
                error_count += vendor_test_plan.content_errors.length	        	          
                if error_count > 0
                  report << "failure\n"
                  report << "Number of errors:, "
                  report << error_count 
                  report << "\n"
                else
                  report << "success\n"
                  report << "Number of errors:, --\n"
                end
              else
                report << "in progress\n"
                report << "Number of errors:, --\n"		  				
              end
              report << "Last Modified:,"
              report << vendor_test_plan.updated_at.strftime("%d.%b.%Y")
              report << "\n\n"
            end
          end
        end
      end
    end

    send_data report, :filename => "report.csv", :type => 'application/x-download'
  end

end
