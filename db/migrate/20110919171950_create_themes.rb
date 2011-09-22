class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    
    create_table :templates do |t|
      t.integer :theme_id
      t.string :type
      t.string :name
      t.text :description
      t.text :raw_item_template
      t.text :serialized_item_template

      t.timestamps
    end
    
  end
end
