class CreateModules < ActiveRecord::Migration
  def change
    create_table :modules do |t|
      t.string :name
      t.integer :section_id
      t.integer :publishable_flag, limit: 1
    end
  end
end
