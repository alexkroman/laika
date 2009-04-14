module PersonLike

  def self.included(base)

    base.class_eval do

      has_one :person_name, :as => :nameable, :dependent => :destroy
      has_one :address, :as => :addressable, :dependent => :destroy
      has_one :telecom, :as => :reachable, :dependent => :destroy

      def initialize(*args)
        super
        self.person_name ||= PersonName.new
        self.address ||= Address.new
        self.telecom ||= Telecom.new
      end

      def copy
        copied_person_like = self.clone
        copied_person_like.save!
        copied_person_like.person_name = self.person_name.clone unless self.person_name.nil?
        copied_person_like.address = self.address.clone unless self.address.nil?
        copied_person_like.telecom = self.telecom.clone unless self.telecom.nil?
        copied_person_like
      end

      def update_person_attributes(params)
        self.person_name ||= PersonName.new
        self.address     ||= Address.new
        self.telecom     ||= Telecom.new
        self.person_name.update_attributes(params[:person_name])
        self.address.update_attributes(params[:address]) 
        self.telecom.update_attributes(params[:telecom])
      end

      def create_person_attributes(params)
        self.person_name = PersonName.new(params[:person_name])
        self.address = Address.new(params[:address])
        self.telecom = Telecom.new(params[:telecom])
      end

      def person_blank?
        %w[ person_name address telecom ].all? {|a| read_attribute(a).blank? }
      end
    end

  end

end
