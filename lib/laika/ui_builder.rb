module Laika
  module UIBuilder

    class View
      attr_reader :fields
      
      def initialize(model)
        @model = model
        @fields = []
      end

      def add_field(attr_name, options={})
        if options[:subattribute]
          submodel = @model.send(attr_name)
          create_field(options[:subattribute], submodel, true, options)
        else
          create_field(attr_name, @model, false, options)
        end
      end
      
      private
      
      def create_field(attr_name, the_model, subobject, options)
        if the_model.has_attribute?(attr_name.to_s)
          @fields << PropertyField.new(attr_name, the_model, subobject, options[:label])
        elsif the_model.class.reflect_on_association(attr_name)
          @fields << SubpropertyField.new(attr_name, the_model, subobject, options[:label])
        else
          #oh noes!
        end
      end
    end
    
    class Field
      attr_reader :model, :subobject
      
      def initialize(name, the_model, subobject, label=nil)
        @name = name
        @model = the_model
        @label = label
        @subobject = subobject
      end
      
      def label
        if @label
          @label
        else
          @name.to_s.humanize
        end
      end
    end
    
    class PropertyField < Field
      def value
        @model.send(@name)
      end
      
      def edit_box(form_object)
        if :date.eql? @model.column_for_attribute(@name).type
          form_object.calendar_date_select(@name)
        else
          form_object.text_field(@name)
        end 
      end
    end
    
    class SubpropertyField < Field
      def value
        @model.send(@name).andand.name
      end
      
      def edit_box(form_object)
        ref = @model.class.reflect_on_association(@name)
        code_class = ref.class_name
        objs = code_class.find(:all, :order => "name ASC")
        form_object.select(@name, objs.collect{|obj| [obj.name, obj.id]}, {:include_blank => true})
      end
    end
  end
end

