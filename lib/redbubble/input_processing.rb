require_relative 'work'
require_relative 'constants'
require 'fileutils'
require 'mimemagic'
require 'nokogiri'


module Redbubble
  class GenericParser
    def initialize(input_file_path)
      # General validations that apply to any file (regardless of its type).
      raise InputFileDoesNotExist, ERRORS[:input_file_does_not_exist] unless File.file? input_file_path
      raise FileEmpty, ERRORS[:file_empty] if File.read(input_file_path).empty?
    end

    def parse
      raise NotImplementedError, NOT_IMPLEMENTED_ERROR_MSG
    end
  end


  class XmlParser < GenericParser
    attr_accessor :doc

    def initialize(input_file_path)
      # For Generic file validations:
      super

      # For more specific (XML file type) validations:
      raise FileNotXML, ERRORS[:file_not_xml] unless MimeMagic.by_path(input_file_path).eql? VALID_INPUT_FILE_TYPE
      doc = Nokogiri::XML(File.read(input_file_path)) { |config| config.strict }

      # All good! document ready to be parsed.
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
