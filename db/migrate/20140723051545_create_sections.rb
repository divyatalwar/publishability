class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
      t.integer :page_id
      t.integer :publishable_flag, limit: 1
    end
  end
end
