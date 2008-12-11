require 'categorizable/divider'

# require extensions
require 'categorizable/class_methods'
require 'categorizable/instance_methods'

# extend ActiveRecord::Base
require 'categorizable/base_extension'
ActiveRecord::Base.extend Categorizable::BaseExtension
