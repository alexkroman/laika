if defined?(JRUBY_VERSION)

  require File.dirname(__FILE__) + '/../spec_helper'
  require  "lib/validators/schematron_validator"


  describe Validators::Schematron::XslProcessor , "can perfrom XSLT transformations" do

  
    it "should be able to perform an xslt transform " do
    
       xml = File.open(File.dirname(__FILE__) + "/../test_data/validators/test.xml","r") do |f| f.read() end
       expected_results = File.open(File.dirname(__FILE__) + "/../test_data/validators/expected_xsl_result.xml","r") do |f| f.read() end
       processor = Validators::Schematron::XslProcessor.new_instance_from_file(File.dirname(__FILE__) + "/../test_data/validators/test.xsl")  
       result =  processor.process(xml)
       result.should.eql? expected_results
     
    end
  
  end


  describe Validators::Schematron::CompiledValidator , "can validate xml against schematron rules" do
  
    it "should validate clinical documents conforming to schematron rules"  do
      validator = Validators::Schematron::CompiledValidator.new(File.dirname(__FILE__) + "/../test_data/validators/compiled_schematron.xsl")
      xml = File.open(File.dirname(__FILE__) + "/../test_data/validators/schematron_test_good.xml","r") do |f| f.read() end
      validator.validate(REXML::Document.new(xml)).should == true
    end
  
    it "should not validate documents not conforming to schematron rules "  do
      validator = Validators::Schematron::CompiledValidator.new(File.dirname(__FILE__) + "/../test_data/validators/compiled_schematron.xsl")
      xml = File.open(File.dirname(__FILE__) + "/../test_data/validators/schematron_test_bad.xml","r") do |f| f.read() end
      validator.validate(REXML::Document.new(xml)).should == false
    end

  
  end

  describe Validators::Schematron::UncompiledValidator , "can validate xml against schematron rules" do
  
    it "should validate clinical documents conforming to schematron rules"  do
      validator = Validators::Schematron::UncompiledValidator.new(File.dirname(__FILE__) + "/../test_data/validators/schematron_rules.xml",File.dirname(__FILE__) + "/../test_data/validators/schematron_1.5_svrl_new.xsl")
       xml = File.open(File.dirname(__FILE__) + "/../test_data/validators/schematron_test_good.xml","r") do |f| f.read() end
      validator.validate(REXML::Document.new(xml)).should == true
    end
  
    it "should not validate documents not conforming to schematron rules "  do
          validator = Validators::Schematron::UncompiledValidator.new(File.dirname(__FILE__) + "/../test_data/validators/schematron_rules.xml",File.dirname(__FILE__) + "/../test_data/validators/schematron_1.5_svrl_new.xsl")
          xml = File.open(File.dirname(__FILE__) + "/../test_data/validators/schematron_test_bad.xml","r") do |f| f.read() end
          validator.validate(REXML::Document.new(xml)).should == false
    end
  
  
  end

end