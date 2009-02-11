if RUBY_PLATFORM =~ /java/
  require "XmlSchema-1.4.2.jar"
  require "commons-collections-3.1.jar"
  require "commons-lang-2.4.jar"
  require "commons-logging-1.1.1.jar"
  require "cxf-2.1.3.jar"
  require "jaxb-impl-2.1.7.jar"
  require "jaxb-xjc-2.1.7.jar"
  require "jettison-1.0.1.jar"
  require "jra-1.0-alpha-4.jar"
  require "neethi-2.0.4.jar"
  require "velocity-1.5.jar"
  require "wsdl4j-1.6.2.jar"
  require "xercesImpl.jar"
  require "xml-resolver-1.2.jar"
  require "xds-client.jar"
else
  warn "xds-client is only for use with JRuby"
end
