require File.dirname(__FILE__) + '/../../spec_helper'

describe "vendor_test_plans/index.html.erb" do
  fixtures :users, :kinds

  before(:each) do
    @controller.stub!(:sort_spec).and_return(nil)
    @patient = Patient.create(:name => 'xfoox',
                                  :user => users(:alex_kroman))
    assigns[:errors] = {}
    assigns[:warnings] = {}
  end

  it "should list a generate-and-format test plan with no clinical document" do
    vtp = VendorTestPlan.create!(:kind => kinds(:generateAndFormat), :patient => @patient)
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
    vtp = VendorTestPlan.create!(:kind => kinds(:generateAndFormat), :patient => @patient)
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
    vtp = VendorTestPlan.create!(:kind => kinds(:generateAndFormat), :patient => @patient)
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
    vtp = VendorTestPlan.create!(:kind => kinds(:displayAndFile), :patient => @patient)
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

  it "should list a pix feed test plan before execute" do
    vtp = VendorTestPlan.create!(:kind => kinds(:pixFeed), :patient => @patient)
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

  it "should list a pix feed test plan after execute" do
    vtp = VendorTestPlan.create!(:kind => kinds(:pixFeed), :patient => @patient)
    vendor = stub(:vendor, :public_id => 'xxxyyy')
    assigns[:vendors] = [vendor]
    assigns[:vendor_test_plans] = { vendor => [ vtp ] }

    test_result = TestResult.new
    test_result.patient_identifier = "XXX"
    test_result.assigning_authority  = "YYY"
    test_result.vendor_test_plan = vtp

    render "vendor_test_plans/index.html.erb"

    response.should have_tag("h3", /#{vendor.public_id}/)
    response.should have_tag("table[id=dashboard]>tr[id=vendor_test_plan_#{vtp.id}]") do
      with_tag 'td>a', /xfoox/
      with_tag 'td>a', /edit/
      with_tag 'td>a', /delete/
    end
  end

  it "should list a pix query and pd query test plan" do
    vtp = VendorTestPlan.create!(:kind => kinds(:pixQuery), :patient => @patient)
    vendor = stub(:vendor, :public_id => 'xxxyyy')
    assigns[:vendors] = [vendor]
    assigns[:vendor_test_plans] = { vendor => [ vtp ] }

    render "vendor_test_plans/index.html.erb"

    response.should have_tag("h3", /#{vendor.public_id}/)
    response.should have_tag("table[id=dashboard]>tr[id=vendor_test_plan_#{vtp.id}]") do
      with_tag 'td>a', /xfoox/
      with_tag 'td>a', /edit/
      with_tag 'td>a', /delete/
      with_tag 'td>a', /checklist/
    end
  end

end
