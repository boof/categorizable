module Categorizable
  module ClassMethods

    def self.extended(base)
      base.has_many :categorizations,
          :class_name => 'Categorizable::Categorization',
          :as => :categorizable, :dependent => :delete_all
      base.has_many :categories, :through => :categorizations

      base.named_scope :wild_scope, proc { |scope| scope }
      base.named_scope :related_to, proc { |*names|
        names << base.base_class.name
        ids = Categorizable::Categorization.
            categorizable_ids_for_names_and_categorizable_type(*names)

        { :conditions => ["#{ base.quoted_table_name }.id IN (?)", ids] }
      }
      base.class_inheritable_reader :category_name_divider
    end

    def set_category_name_divider(divider)
      write_inheritable_attribute :category_name_divider,
          Categorizable::Divider.new(divider)
    end

  end
end
