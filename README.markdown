Categorizable
=============

Simply categorize (tag) your ActiveRecord models.


Example
-------

    class Item < ActiveRecord::Base
      categorizable
    end
    item = Item.create :category_names => 'Example Category, Item'

    Categorizable::Category.find :all # => [
      #<Categorizable::Category id: 1, name: "Example Category", ...>,
      #<Categorizable::Category id: 2, name: "Item", ...>
    ]

    item.category_names # => 'Example Category, Item'

    relative = Item.create :category_names => item.category_names
    Item.related_to 'Example Category' # => [item, relative]
    item.relatives # => [relative]


Install
-------

    $ script/plugin install git://github.org/boof/categorizable

or

    $ git submodule add git://github.org/boof/categorizable vendor/plugins/categorizable
    $ cd vendor/plugins/categorizable && ruby install.rb


Copyright (c) 2008 Florian Aßmann, released under the MIT license
