require_relative 'errors'
require_relative 'input_helper'

module Redbubble
  class Runner
    def run
      begin
        # COMMAND LINE ARGS VALIDATION & PREP
        user_input = InputHelper.new(ARGV)
        input_file_path, output_dir_path = user_input.validate_and_prep!
        
        # XML PROCESSING
        # parser = GenericParser.new
        # works = parser.parse(XMLParser.new(input_file_path))

        # HTML GENERATION
        # generation = HtmlGeneration.new(works, output_dir_path)
        # generation.go!
      rescue InputArgumentsError => e
        puts "InputArgumentsError: #{e.message}"
        puts "StackTrace: #{e.backtrace}"
        exit
      rescue Exception => e
        puts "Error: #{e.message}"
        puts "StackTrace: #{e.backtrace}"
        exit
      end
    end
  end
end
