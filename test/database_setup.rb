ActiveRecord::Base.establish_connection(
 :adapter => 'sqlite3',
 :database  => ':memory:'
)

if $-v
  ActiveRecord::Base.logger = ActiveSupport::BufferedLogger.new(STDOUT)
  ActiveRecord::Base.colorize_logging = false
end

ActiveRecord::Base.connection.instance_eval do
  create_table :categorizable_categories do |t|
    t.string   :name, :null => false
    t.timestamps
  end
  add_index :categorizable_categories, :name, :unique => true
  create_table :categorizable_categorizations do |t|
    t.references :category, :null => false
    t.references :categorizable, :polymorphic => true, :null => false
    t.timestamps
  end
  add_index :categorizable_categorizations, :category_id
  add_index :categorizable_categorizations, [:categorizable_id, :categorizable_type]
  add_index :categorizable_categorizations, [:category_id, :categorizable_id, :categorizable_type], :unique => true

  create_table(:items) {}
end
