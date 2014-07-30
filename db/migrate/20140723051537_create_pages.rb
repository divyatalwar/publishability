class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :page_title
      t.string :keywords
      t.text :description
      t.integer :site_id
      t.integer :publishable_flag, limit: 1
    end
  end
end
