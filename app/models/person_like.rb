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
    end
  end
end