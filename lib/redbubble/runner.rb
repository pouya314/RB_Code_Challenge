module Redbubble
  class Runner
    def run
      # COMMAND LINE ARGS VALIDATION & PREP
      user_input = InputHelper.new(ARGV)
      input_file_path, output_dir_path = user_input.validate_and_prep!
      
      # XML PROCESSING
      parser = GenericParser.new
      works = parser.parse(XMLParser.new(input_file_path))

      # HTML GENERATION
      generation = HtmlGeneration.new(works, output_dir_path)
      generation.go!
    end
  end
end
