class RedBubbleError < Exception; end

  class NoArgumentsPassed < RedBubbleError; end
  class WrongNoOfArgs < RedBubbleError; end
  class InputFileDoesNotExist < RedBubbleError; end
  
  class FileNotXML < RedBubbleError; end
