class RedBubbleError < Exception; end

  class InputArgumentsError < RedBubbleError; end
    class NoArgumentsPassed < InputArgumentsError; end
    class WrongNoOfArgs < InputArgumentsError; end
    class InputFileDoesNotExist < InputArgumentsError; end


# class InputFileDoesNotExist < RedBubbleException; end

# ... etc