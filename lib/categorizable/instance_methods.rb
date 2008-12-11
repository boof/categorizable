module Categorizable
  module InstanceMethods

    def category_names
      collect_category_names * "#{ category_name_divider } "
    end
    def category_names=(names)
      names = category_name_divider.divide "#{ names }"
      collection = Categorizable::Category.find_all_by_names(*names)

      for category in collection
        names.delete category.name
      end
      while name = names.shift
        collection << Categorizable::Category.new(:name => name)
      end

      self.categories = collection
    end

    def relatives
      pk_col_name = self.class.primary_key
      pk          = self.send pk_col_name

      self.class.related_to(*collect_category_names).all :conditions => [
          "#{ self.class.quoted_table_name }.#{ pk_col_name } != ?", pk]
    end

    protected
    def collect_category_names
      categories.loaded??
        categories.map { |c| c.name } :
        categories.find(:all, :select => :name).map! { |c| c.name }
    end

  end
end
