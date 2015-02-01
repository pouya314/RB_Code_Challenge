module Redbubble
  class RedbubbleSystemController
    def initialize
      # Create main components/objects of the system here? ...
    end

    def execute
      # 1) argv1, argv2 = Validate input (command-line arguments)
      # 2) Send argv1 to Utils for folder structure creation if necessary
      # 3) all_works = [work, work, work, ...] = Send argv2 to InputProcessor for processing (be it XML, HTML, or ...)
      # 4) tell HTMLProducer to produce the static html files..
      # 5) return to caller (i.e. runner) to terminate the program execution.
    end
  end
end
