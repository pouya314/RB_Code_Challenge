module Redbubble
  class XmlParser
    def initialize(doc)
      @doc = doc
    end
    
    def parse
      # ...
    end
  end

  class GenericParser
    def parse(parser)
      parser.parse
    end
  end
end