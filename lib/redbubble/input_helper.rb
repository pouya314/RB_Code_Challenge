require_relative 'errors'
require_relative 'constants'


module Redbubble
  class InputHelper
    attr_accessor :cmd_arguments

    def initialize(cmd_arguments)
      @cmd_arguments = cmd_arguments
    end

    def validate_argv!
      raise NoArgumentsPassed, ERRORS[:no_arguments_passed] if cmd_arguments.empty?
      raise WrongNoOfArgs, ERRORS[:wrong_number_of_arguments] unless cmd_arguments.count == 2

      return cmd_arguments[0], cmd_arguments[1]

      # unless Dir.exist? output_dir_path
      #   FileUtils::mkdir_p output_dir_path
      #   puts ERRORS[:output_dir_did_not_exist_but_created]
      # end
    end
  end
end
