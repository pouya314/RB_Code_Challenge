require_relative 'xml_parser_validations'
require_relative 'work'
require_relative 'constants'


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
      doc.css(NOKOGIRI[:css][:access_work_nodes]).each do |i|
          works << Work.new(
                      if i.at_css(NOKOGIRI[:css][:access_work_thumb_url]) == nil then nil else i.at_css(NOKOGIRI[:css][:access_work_thumb_url]).content end,
                      if i.at_css(NOKOGIRI[:css][:access_work_make]) == nil then nil else i.at_css(NOKOGIRI[:css][:access_work_make]).content end,
                      if i.at_css(NOKOGIRI[:css][:access_work_model]) == nil then nil else i.at_css(NOKOGIRI[:css][:access_work_model]).content end)
      end
      works
    end
  end
end
