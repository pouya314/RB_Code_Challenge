require_relative 'errors'
require_relative 'input_helper'
require_relative 'input_processing'

module Redbubble
  class Runner
    def run
      begin
        # COMMAND LINE ARGS VALIDATION & PREP
        user_input = InputHelper.new(ARGV)
        input_file_path, output_dir_path = user_input.validate_and_prep!
        
        # XML PROCESSING
        parser = GenericParser.new
        works = parser.parse(XmlParser.new(input_file_path))

        # HTML GENERATION
        # generation = HtmlGeneration.new(works, output_dir_path)
        # generation.go!
      rescue NoArgumentsPassed, WrongNoOfArgs, InputFileDoesNotExist => e
        puts "Input arguments error: #{e}"
        puts "StackTrace: #{e.backtrace}"
        exit
      rescue FileNotXML => e
        puts "Input processing error: #{e}"
        puts "StackTrace: #{e.backtrace}"
        exit
      rescue Nokogiri::XML::SyntaxError => e
        puts "[from Nokogiri] Input processing error: #{e}"
        puts "StackTrace: #{e.backtrace}"
        exit
      rescue Exception => e
        puts "#{e}"
        puts "StackTrace: #{e.backtrace}"
        exit
      end
    end
  end
end
