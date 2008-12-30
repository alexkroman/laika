module Validators
  module Schema
    class Validator
      require 'java'
      import 'javax.xml.validation.SchemaFactory'
      import 'javax.xml.XMLConstants'
      import 'java.net.URL'
      import 'javax.xml.transform.stream.StreamSource'
      import 'java.io.StringReader'
      import 'org.xml.sax.SAXException'
      import 'javax.xml.parsers.DocumentBuilder'
      import 'javax.xml.parsers.DocumentBuilderFactory'
      import 'java.io.ByteArrayInputStream'
      
      
      attr_accessor :validator_name
      
      def initialize(name, schema_file)
        @validator_name = name
        set_schema(schema_file)
      end
      
      def validate(document)
        begin 
          doc = @document_builder.parse(ByteArrayInputStream.new(java.lang.String.new(document.to_s).getBytes))
          source = javax.xml.transform.dom.DOMSource.new(doc)
          validator = @schema.newValidator();
          validator.validate(source);
       rescue 
          puts $!
          # this is where we will do something with the error
       end
       
      end
      
      
      private 
      
      def set_schema(file)
 
        factory = SchemaFactory.newInstance(XMLConstants::W3C_XML_SCHEMA_NS_URI)
        schemaFile =  StreamSource.new(java.io.File.new(file));
        @schema = factory.newSchema(schemaFile)
        @document_builder = DocumentBuilderFactory.newInstance().newDocumentBuilder()
      end

    end
  end
end
  