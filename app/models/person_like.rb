module PersonLike
  def self.included(base)
    base.class_eval do
      has_one :person_name, :as => :nameable
      has_one :address, :as => :addressable
      has_one :telecom, :as => :reachable
      
      def copy
        copied_person_like = self.clone
        copied_person_like.save!
        copied_person_like.person_name = self.person_name.clone unless self.person_name.nil?
        copied_person_like.address = self.address.clone unless self.address.nil?
        copied_person_like.telecom = self.telecom.clone unless self.telecom.nil?
        copied_person_like
      end
      
      def update_person_attributes(params)
        self.person_name.update_attributes(params[:person_name])
        self.address.update_attributes(params[:address]) 
        self.telecom.update_attributes(params[:telecom])
      end
      
      def create_person_attributes(params)
        
        self.person_name = PersonName.new(params[:person_name])
        self.address = Address.new(params[:address])
        self.telecom = Telecom.new(params[:telecom])
      end
      
      def has_any_data
        
        if self.person_name != nil
          if !self.person_name.name_prefix.blank? ||
             !self.person_name.first_name.blank? ||
             !self.person_name.last_name.blank? ||
             !self.person_name.name_suffix.blank?
             return true
          end
        end
        
        if self.address!= nil
          if !self.address.street_address_line_one.blank? ||
             !self.address.street_address_line_two.blank? ||
             !self.address.city.blank? ||
             !self.address.state.blank? ||
             !self.address.postal_code.blank? ||
             !self.address.iso_country_id.blank? 
             return true
          end
        end
        
        if self.telecom != nil
          if !self.telecom.home_phone.blank? ||
             !self.telecom.work_phone.blank? ||
             !self.telecom.mobile_phone.blank? ||
             !self.telecom.vacation_home_phone.blank? ||
             !self.telecom.email.blank? ||
             !self.telecom.url.blank?
             return true
          end
        end
        
        return false
        
      end
    end
  end
end