 module PatientDataC32Validation



    def validate_c32(clinical_document)

      errors = []

      # Registration information
       errors.concat((self.registration_information.andand.validate_c32(clinical_document)).to_a)
      # Languages
        self.languages.each do |language|
          errors.concat(language.validate_c32(clinical_document))
        end

      # Healthcare Providers

        self.providers.each do |provider|
          errors.concat(provider.validate_c32(clinical_document))
        end

      # Insurance Providers

        self.insurance_providers.each do |insurance_providers|
          errors.concat(insurance_providers.validate_c32(clinical_document))
        end


      # Medications
        self.medications.each do |medication|
          errors.concat(medication.validate_c32(clinical_document))
        end

      # Supports          
        errors.concat(self.support.validate_c32(clinical_document)) if self.support

      # Allergies
        self.allergies.each do |allergy|
          errors.concat(allergy.validate_c32(clinical_document))
        end

      # Conditions
        self.conditions.each do |condition|
          errors.concat(condition.validate_c32(clinical_document))
        end  

      # Information Source
     
        # Need to pass in the root element otherwise the first XPath expression doesn't work
        errors.concat(self.information_source.validate_c32(clinical_document.root))  if self.information_source

      # Advance Directive      
        errors.concat(self.advance_directive.validate_c32(clinical_document)) if self.advance_directive

      # Results
        self.results.each do |result|
          errors.concat(result.validate_c32(clinical_document))
        end

      # Immunizations
        self.immunizations.each do |immunization|
          errors.concat(immunization.validate_c32(clinical_document))
        end

      # Encounters
        self.encounters.each do |encounter|
          errors.concat(encounter.validate_c32(clinical_document))
        end

      # Removes all the nils... just in case.
      errors.compact!
      errors
    end



  end
