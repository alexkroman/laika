unless ENV['RAILS_ENV'] == "test" || ENV['RAILS_ENV'].nil?
  require 'lib/validation.rb'
  require 'lib/validators/c32_validator.rb'
  require 'lib/validators/schema_validator.rb'
  require 'lib/validators/schematron_validator.rb'
  require 'lib/validators/umls_validator.rb'
  Validation.register_validator :C32, Validators::C32Validation::Validator.new
  Validation.register_validator :C32, Validators::Schema::Validator.new("C32 Schema Validator", "resources/schemas/infrastructure/cda/C32_CDA.xsd")
  Validation.register_validator :C32, Validators::Schematron::CompiledValidator.new("CCD Schematron Validator","resources/schematron/ccd_errors.xslt")
  Validation.register_validator :C32, Validators::Schematron::CompiledValidator.new("C32 Schematron Validator","resources/schematron/c32_v2.1_errors.xslt")
  #Validation.register_validator :C32, Validators::Umls::UmlsValidator.new("warning")
  #Validation.register :C32, Validators::Schematron::SchematronValidator.new
end

