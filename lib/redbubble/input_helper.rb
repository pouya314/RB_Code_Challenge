require_relative 'errors'
require 'fileutils'

module Redbubble
  class InputHelper
    attr_accessor :cmd_arguments
    
    def initialize(cmd_arguments)
      @cmd_arguments = cmd_arguments
    end
    
    def validate_and_prep!
      raise NoArgumentsPassed, "You need to pass in some arguments." if cmd_arguments.empty?
      raise WrongNoOfArgs, "This program expects exactly 2 arguments." unless cmd_arguments.count == 2
      
      input_file_path, output_dir_path = cmd_arguments[0], cmd_arguments[1]
      
      raise InputFileDoesNotExist, "Input file you specified does NOT exist." unless File.file? input_file_path
      
      unless Dir.exist? output_dir_path
        FileUtils::mkdir_p output_dir_path
        puts "The output directory path you specified did not exist, but we created it for you."
      end
      
      return input_file_path, output_dir_path
    end
  end
end