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
        self.address = Address.new(params[:address])
        
        if (params[:iso_country_id] != nil)
          self.address.iso_country = IsoCountry.find(params[:iso_country_id])
          self.address.save!
        end
        
        if (params[:contact_type_id] != nil)
           self.contact = ContactType.find(params[:contact_type_id])
           self.contact.save!
        end
       
        if (params[:relationship_id] != nil)
           self.relationship = Relationship.find(params[:relationship_id])
           self.relationship.save!
        end

        self.telecom.update_attributes(params[:telecom])
      end
      
      def create_person_attributes(params)
        self.person_name = PersonName.new(params[:person_name])
        
        self.address = Address.new(params[:address])
        if (params[:iso_country_id] != nil)
          self.address.iso_country = IsoCountry.find(params[:iso_country_id])
          self.address.save!
        end
        
        if (params[:contact_type_id] != nil)
           self.contact = ContactType.find(params[:contact_type_id])
           self.contact.save!
        end
       
        if (params[:relationship_id] != nil)
           self.relationship = Relationship.find(params[:relationship_id])
           self.relationship.save!
        end
   
        self.telecom = Telecom.new(params[:telecom])
      end
    end
  end
end