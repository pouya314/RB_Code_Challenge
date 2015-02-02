require_relative 'xml_parser_validations'
require_relative 'work'

module Redbubble
  class GenericParser
    def parse(parser)
      parser.parse
    end
  end

  class XmlParser
    prepend XmlParserValidations

    attr_accessor :doc

    def initialize(doc)
      @doc = doc
    end

    def parse
      works = Array.new
      doc.css('work').each do |i|
          works << Work.new(
                      if i.at_css("urls url[type='small']") == nil then nil else i.at_css("urls url[type='small']").content end,
                      if i.at_css("exif make") == nil then nil else i.at_css("exif make").content end,
                      if i.at_css("exif model") == nil then nil else i.at_css("exif model").content end)
      end
      return works
    end
  end
end
