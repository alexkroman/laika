class PersonName < ActiveRecord::Base

  strip_attributes!

  belongs_to :nameable, :polymorphic => true



  def requirements
    case nameable_type
    when 'RegistrationInformation'
    {
      :first_name => :required,
      :last_name => :required,
    }
    when 'InformationSource':
    {
      :first_name => :required,
      :last_name => :required,
    }
    when 'Provider':
    {
      :first_name => :hitsp_r2_optional,
      :last_name => :hitsp_r2_optional,
    }
    when 'InsuranceProviderPatient', 'InsuranceProviderSubscriber', 'InsuranceProviderGuarantor':
    {
      :first_name => :required,
      :last_name => :required,

    }
    when 'AdvanceDirective':
    {
      :first_name => :hitsp_required,
      :last_name => :hitsp_required

    }
    when 'Encounter':
    {
      :first_name => :hitsp_r2_required,
      :last_name => :hitsp_r2_required,
    }
    end
  end



  def to_c32(xml)
    xml.name do
      if name_prefix &&  name_prefix.size > 0
        xml.prefix(name_prefix)
      end
      if first_name &&  first_name.size > 0
        xml.given(first_name, "qualifier" => "CL")
      end
      if last_name && last_name.size > 0
        xml.family(last_name, "qualifier" => "BR")
      end
      if name_suffix && name_suffix.size > 0
        xml.suffix(name_suffix)
      end
    end
  end

end
