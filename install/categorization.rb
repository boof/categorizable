module Categorizable
  class Categorization < ActiveRecord::Base

    set_table_name 'categorizable_categorizations'

    belongs_to :category, :class_name => 'Categorizable::Category'
    validates_presence_of :category_id
    belongs_to :categorizable, :polymorphic => true
    validates_presence_of :categorizable_type, :categorizable_id

    def self.categorizable_ids_for_names_and_categorizable_type(*names)
      select = 'SELECT DISTINCT categorizable_id, categorizable_type' +
          ' FROM categorizable_categorizations'
      type = names.pop

      category_ids = Categorizable::Category.ids_for_names(*names)
      select << " WHERE category_id IN (#{ category_ids * ',' })"

      categorizable_type_column = columns_hash['categorizable_type']
      quoted_categorizable_type = quote_value type, categorizable_type_column
      select << " AND categorizable_type = #{ quoted_categorizable_type }"

      ActiveRecord::Base.connection.select_values select
    end

  end
end
