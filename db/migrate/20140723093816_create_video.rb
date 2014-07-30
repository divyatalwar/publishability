class CreateVideo < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :url
      t.integer :publishable_flag, limit: 1
    end
  end
end
