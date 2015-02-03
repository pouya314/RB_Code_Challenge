class RedBubbleError < Exception; end

  # Input helper exceptions
  class NoArgumentsPassed < RedBubbleError; end
  class WrongNoOfArgs < RedBubbleError; end


  # Generic Processor exceptions
  class InputFileDoesNotExist < RedBubbleError; end
  class FileEmpty < RedBubbleError; end


  # Xml Processor exceptions
  class FileNotXML < RedBubbleError; end


  # html generation exceptions
  class InsifficientWorkData < RedBubbleError; end
