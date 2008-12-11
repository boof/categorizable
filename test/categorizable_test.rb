require 'test_helper'

class Item < ActiveRecord::Base
  categorizable
  set_category_name_divider ';'
end

Expectations do

  expect category_names = %w[ Foo Bar ].sort do
    custom_divider        = Item.category_name_divider
    category_names_string = category_names * custom_divider.to_s

    Item.new(:category_names => category_names_string).
        instance_eval { custom_divider.split(self.category_names).sort }
  end

  expect [ item = Item.create(:category_names => 'Foo; Bar') ] do
    relatives = Item.create(:category_names => item.category_names).relatives

    # clean up
    Item.destroy_all

    relatives
  end

end
