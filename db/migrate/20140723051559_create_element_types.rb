class CreateElementTypes < ActiveRecord::Migration
  def change
    create_table :element_types do |t|
      t.integer :module_id
      t.integer :element_id
      t.string :element_type
      
    end
  end
end
