module Categorizable
  class Divider

    def initialize(divider)
      @divider = divider
    end
    def to_s
      @divider
    end
    def split(string)
      category_names = string.split @divider
      category_names.each { |name| name.strip! }
    end

  end
end