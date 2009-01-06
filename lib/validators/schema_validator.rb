module Validators
  module Schema
    class Validator
      require 'java'
      import 'javax.xml.validation.SchemaFactory'
      import 'javax.xml.XMLConstants'
      import 'javax.xml.transform.stream.StreamSource'
      import 'javax.xml.parsers.DocumentBuilder'
      import 'javax.xml.parsers.DocumentBuilderFactory'
      import 'java.io.ByteArrayInputStream'
      
      
      attr_accessor :validator_name
      
      def initialize(name, schema_file)
        @validator_name = name
        set_schema(schema_file)
      end
      
      # Validate the document against the configured schema
      def validate(document)
        valid = true
        begin 
          doc = @document_builder.parse(ByteArrayInputStream.new(java.lang.String.new(document.to_s).getBytes))
          source = javax.xml.transform.dom.DOMSource.new(doc)
          validator = @schema.newValidator();
          validator.validate(source);
       rescue 
          # this is where we will do something with the error
          valid = false
       end
       valid
      end
      
      
      private 
      # set the schema file and create the java objects to perfrom the validation
      def set_schema(file)
        factory = SchemaFactory.newInstance(XMLConstants::W3C_XML_SCHEMA_NS_URI)
        schemaFile =  StreamSource.new(java.io.File.new(file));
        @schema = factory.newSchema(schemaFile)
        @document_builder = DocumentBuilderFactory.newInstance().newDocumentBuilder()
      end

    end
  end
end
  