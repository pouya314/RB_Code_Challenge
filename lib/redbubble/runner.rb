require_relative 'errors'
require_relative 'constants'
require_relative 'input_helper'
require_relative 'input_processing'
require_relative 'html_generation'
require 'launchy'


module Redbubble
  class Runner
    def run
      begin
        # 1/
        # Handle user input
        user_input = InputHelper.new(ARGV)
        input_file_path, output_dir_path = user_input.validate_argv!

        # 2/
        # Parse XML
        parser = XmlParser.new(input_file_path)
        works = parser.parse

        # 3/
        # Create HTML files
        generation = HtmlGeneration.new(works, output_dir_path)
        generation.go!

        # 4/
        # Launch Browser
        uri = "#{OUTPUT_PROTOCOL}#{output_dir_path}/#{INDEX[:file_name]}"
        Launchy.open(uri) do |exception|
          puts ERRORS[:launchy_failed]
        end

      rescue NoArgumentsPassed, WrongNoOfArgs => e
        puts e
        puts e.backtrace
        exit
      rescue InputFileDoesNotExist, FileEmpty => e
        puts e
        puts e.backtrace
        exit
      rescue FileNotXML, Nokogiri::XML::SyntaxError => e
        puts e
        puts e.backtrace
        exit
      rescue InsifficientWorkData => e
        puts e
        puts e.backtrace
        exit
      rescue Exception => e
        puts e
        puts e.backtrace
        exit
      end
    end
  end
end
