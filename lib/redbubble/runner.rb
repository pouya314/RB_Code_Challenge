module Redbubble
  class Runner
    def run
      # 1) Send ARGV (Array) to input helper for:
      # - Input Validation (correct number of arguments, existance of xml file, etc)
      # - Folder structure creation if necessary
      user_input = InputHelper.new(ARGV)
      input_file_path, output_dir_path = user_input.sanitize!
      
      
      # 2) all_works = [work, work, work, ...] = Send argv2 to InputProcessor for processing (be it XML, HTML, or ...)      
      parser = GenericParser.new
      works = parser.parse(XMLParser.new(input_file_path))
      
      # 3) tell HTMLProducer to produce the static html files..
      generation = HtmlGeneration.new(works, output_dir_path)
      generation.go!
    end
  end
end
