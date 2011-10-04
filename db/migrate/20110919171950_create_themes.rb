class CreateThemes < ActiveRecord::Migration
  def change
    create_table :liquid_themes do |t|
      t.string  :name
      t.text    :description

      t.timestamps
    end
    
    create_table :liquid_templates do |t|
      t.integer :liquid_theme_id
      t.string  :type
      t.string  :name
      t.string  :classname
      t.text    :description
      t.text    :raw_item_template
      t.text    :serialized_item_template

      t.timestamps
    end
    
    create_table :theme_assets do |t|
      t.string      :local_path
      t.string      :content_type
      t.integer     :width
      t.integer     :height
      t.integer     :size
      t.string      :folder
      t.string      :source
      
      t.timestamps
    end
    
  end
end