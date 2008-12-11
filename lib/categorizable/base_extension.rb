module Categorizable
  module BaseExtension

    DEFAULT_OPTIONS = {:divider => ','}
    VALID_OPTIONS = [:divider].freeze

    def self.sanitize_options(options)
      DEFAULT_OPTIONS.merge(options).
          reject { |key, value| not VALID_OPTIONS.include? key }
    end

    def categorizable(options = {})
      options = Categorizable::BaseExtension.sanitize_options options

      extend Categorizable::ClassMethods
      include Categorizable::InstanceMethods

      set_category_name_divider options[:divider]
    end

  end
end
