require File.dirname(__FILE__) + '/../spec_helper'

describe Language, "it can validate language entries in a C32" do
  fixtures :languages, :iso_languages, :iso_countries, :language_ability_modes
  
  it "should verify an language matches in a C32 doc" do
    document = REXML::Document.new(File.new(RAILS_ROOT + '/spec/test_data/joe_c32.xml'))
    joe_language = languages(:joe_smith_english_language)
    errors = joe_language.validate_c32(document)
    puts errors.map { |e| e.error_message }.join(' ')
    errors.should be_empty
  end
end