require_relative 'errors'
require_relative 'constants'
require 'fileutils'


module Redbubble
  class InputHelper
    attr_accessor :cmd_arguments

    def initialize(cmd_arguments)
      @cmd_arguments = cmd_arguments
    end

    def validate_and_prep!
      raise NoArgumentsPassed, ERRORS[:no_arguments_passed] if cmd_arguments.empty?
      raise WrongNoOfArgs, ERRORS[:wrong_number_of_arguments] unless cmd_arguments.count == 2

      input_file_path, output_dir_path = cmd_arguments[0], cmd_arguments[1]

      raise InputFileDoesNotExist, ERRORS[:input_file_does_not_exist] unless File.file? input_file_path

      unless Dir.exist? output_dir_path
        FileUtils::mkdir_p output_dir_path
        puts ERRORS[:output_dir_did_not_exist_but_created]
      end

      return input_file_path, output_dir_path
    end
  end
end
