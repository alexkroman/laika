module PersonLike

  def self.included(base)
    base.class_eval do
      has_one :person_name, :as => :nameable, :dependent => :destroy
      has_one :address, :as => :addressable, :dependent => :destroy
      has_one :telecom, :as => :reachable, :dependent => :destroy
      include PersonLikeInstance
    end
  end

  module PersonLikeInstance
    def initialize(*args)
      super
      self.person_name ||= PersonName.new
      self.address ||= Address.new
      self.telecom ||= Telecom.new
    end

    def clone
      copy = super
      copy.save!
      copy.person_name = person_name.clone if person_name
      copy.address     = address.clone     if address
      copy.telecom     = telecom.clone     if telecom
      copy
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
