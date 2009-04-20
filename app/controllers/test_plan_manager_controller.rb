class TestPlanManagerController < ApplicationController
  def assign_patient

    patient = Patient.find(params[:pd_id]).clone

    # find the associated meta-data
    test_plan = params[:vendor_test_plan]
    vendor = Vendor.find(test_plan[:vendor_id])
    kind = Kind.find(test_plan[:kind_id])
    user = current_user.administrator? ? User.find(test_plan[:user_id]) : current_user

    # save the vendor/kind selections for next time
    self.last_selected_vendor_id = vendor.id
    self.last_selected_kind_id   = kind.id

    vtp = VendorTestPlan.new(:vendor => vendor, :kind => kind, :user => user)
    if params[:metadata]
      if params[:metadata].kind_of?(String)
        vtp.metadata = YAML.load(params[:metadata])         
      else
        md = XDS::Metadata.new
        md.from_hash(params[:metadata], AFFINITY_DOMAIN_CONFIG)
        vtp.metadata = md
      end

    end
    vtp.save!

    patient.vendor_test_plan = vtp
    patient.save!

    if vtp.metadata 
        doc = XDSUtils.retrieve_document(vtp.metadata)
        cd = ClinicalDocument.new(:uploaded_data=>doc, :vendor_test_plan_id=>vtp.id)
        vtp.clinical_document = cd   
    end
    
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
              report << vendor_test_plan.patient.name + "\n" 	
              @kinds.each do |kind|
                if kind.id == vendor_test_plan.kind_id
                  report << "Inspection Type:,"
                  report << kind.name + "\n"
                  break
                end
              end
              report << "Result:,"
              error_count = 0
              if vendor_test_plan.clinical_document
                error_count = vendor_test_plan.content_errors.length	        	          
                if error_count > 0
                  report << "failure\n"
                  report << "Number of errors:, "
                  report << error_count.to_s
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
