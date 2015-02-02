module Redbubble
  class InputHelper
    def initialize(arguments)
      @arguments = arguments
    end
    
    def validate_and_prep!
      # command line arguments are not empty?
      # number of command line arguments is 2.
      # does the input file exist?
      # does the output directory exist? if not, maybe create it?
    end
  end
end