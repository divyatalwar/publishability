class CreateImage < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :url
      t.string :title
      t.string :alt
      t.integer :publishable_flag, limit: 1
    end
  end
end
