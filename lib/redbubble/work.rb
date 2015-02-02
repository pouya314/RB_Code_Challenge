module Redbubble
  class Work
    attr_accessor :url, :make_name, :model_name

    def initialize(url, make_name, model_name)
      @url        = url
      @make_name  = make_name
      @model_name = model_name
    end

    def invalid?
      url == nil || make_name == nil || model_name == nil
    end
  end
end
