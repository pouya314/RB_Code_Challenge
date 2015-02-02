require_relative 'errors'
require_relative 'settings'
require_relative 'input_helper'
require_relative 'input_processing'
require_relative 'html_generation'
require 'launchy'


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
        generation = HtmlGeneration.new(works, output_dir_path)
        generation.go!

        # Launch the browser (if possible)
        uri = "#{OUTPUT_PROTOCOL}#{output_dir_path}#{INDEX[:file_name]}"
        Launchy.open(uri) do |exception|
          puts "Attempted to open #{uri} and failed because #{exception}"
        end
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
