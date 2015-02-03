module Redbubble
  class Work
    attr_accessor :url, :make_name, :model_name

    def initialize(url, make_name, model_name)
      @url        = url
      @make_name  = make_name
      @model_name = model_name
    end

    def invalid?
      url == nil ||
      url.chomp.strip.empty? ||
      make_name == nil ||
      make_name.chomp.strip.empty? ||
      model_name == nil ||
      model_name.chomp.strip.empty?
    end
  end
end
