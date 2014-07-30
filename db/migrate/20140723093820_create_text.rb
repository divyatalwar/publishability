class CreateText < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text :content
      t.integer :publishable_flag, limit: 1
    end
  end
end
