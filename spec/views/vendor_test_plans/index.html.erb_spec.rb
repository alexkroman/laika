require File.dirname(__FILE__) + '/../../spec_helper'

describe "vendor_test_plans/index.html.erb" do
  fixtures :users, :kinds

  before(:each) { @controller.stub!(:sort_spec).and_return(nil) }

  it "should list a generate-and-format test plan with no clinical document" do
    vtp = VendorTestPlan.create(
      :kind => kinds(:generateAndFormat),
      :patient_data => PatientData.create(:name => 'xfoox',
                                          :user => users(:alex_kroman)))
    vendor = stub(:vendor, :public_id => 'xxxyyy')
    assigns[:vendors] = [vendor]
    assigns[:vendor_test_plans] = { vendor => [ vtp ] }

    render "vendor_test_plans/index.html.erb"

    response.should have_tag("h3", /#{vendor.public_id}/)
    response.should have_tag("table[id=dashboard]>tr[id=vendor_test_plan_#{vtp.id}]") do
      with_tag 'td>a', /xfoox/
      with_tag 'td>a', /edit/
      with_tag 'td>a', /delete/
      with_tag 'td>a', /execute/
    end
  end

  it "should list a generate-and-format test plan with a validated clinical document" do
    vtp = VendorTestPlan.create(
      :kind => kinds(:generateAndFormat),
      :patient_data => PatientData.create(:name => 'xfoox',
                                          :user => users(:alex_kroman)))
    doc = ClinicalDocument.new
    doc.filename = 'xxx'
    doc.size = 1
    vtp.clinical_document = doc
    vendor = stub(:vendor, :public_id => 'xxxyyy')
    assigns[:vendors] = [vendor]
    assigns[:vendor_test_plans] = { vendor => [ vtp ] }
    vtp.stub!(:validated?).and_return(true)
    assigns[:warnings] = { vtp => 2 }
    assigns[:errors] = { vtp => 0 }

    render "vendor_test_plans/index.html.erb"

    response.should have_tag("h3", /#{vendor.public_id}/)
    response.should have_tag("table[id=dashboard]>tr[id=vendor_test_plan_#{vtp.id}]") do
      with_tag 'td', /xfoox/
      with_tag 'td', '2 Warnings'
      with_tag 'td>a', /inspect/
      with_tag 'td>a', /checklist/
      with_tag 'td>a', /delete/
    end
  end

  it "should list a generate-and-format test plan with an invalid clinical document" do
    vtp = VendorTestPlan.create(
      :kind => kinds(:generateAndFormat),
      :patient_data => PatientData.create(:name => 'xfoox',
                                          :user => users(:alex_kroman)))
    doc = ClinicalDocument.new
    doc.filename = 'xxx'
    doc.size = 1
    vtp.clinical_document = doc
    vendor = stub(:vendor, :public_id => 'xxxyyy')
    assigns[:vendors] = [vendor]
    assigns[:vendor_test_plans] = { vendor => [ vtp ] }
    vtp.stub!(:validated?).and_return(true)
    assigns[:warnings] = { vtp => 0 }
    assigns[:errors] = { vtp => 3 }

    render "vendor_test_plans/index.html.erb"

    response.should have_tag("h3", /#{vendor.public_id}/)
    response.should have_tag("table[id=dashboard]>tr[id=vendor_test_plan_#{vtp.id}]") do
      with_tag 'td', /xfoox/
      with_tag 'td', '3 Errors'
      with_tag 'td>a', /inspect/
      with_tag 'td>a', /checklist/
      with_tag 'td>a', /delete/
    end
  end



  it "should list a display-and-file test plan" do
    vtp = VendorTestPlan.create(
      :kind => kinds(:displayAndFile),
      :patient_data => PatientData.create(:name => 'xfoox',
                                          :user => users(:alex_kroman)))
    vendor = stub(:vendor, :public_id => 'xxxyyy')
    assigns[:vendors] = [vendor]
    assigns[:vendor_test_plans] = { vendor => [ vtp ] }

    render "vendor_test_plans/index.html.erb"

    response.should have_tag("h3", /#{vendor.public_id}/)
    response.should have_tag("table[id=dashboard]>tr[id=vendor_test_plan_#{vtp.id}]") do
      with_tag 'td>a', /xfoox/
      with_tag 'td>a', /edit/
      with_tag 'td>a', /delete/
      with_tag 'td>a', /xml/
      with_tag 'td>a', /checklist/
    end
  end

end


