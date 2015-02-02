require_relative 'constants'
require 'mimemagic'
require 'nokogiri'


module XmlParserValidations
  def initialize(doc_path)
    raise FileNotXML, ERRORS[:file_not_xml] unless MimeMagic.by_path(doc_path).eql? VALID_INPUT_FILE_TYPE
    doc = Nokogiri::XML(File.read(doc_path)) { |config| config.strict }
    super(doc)
  end
end
