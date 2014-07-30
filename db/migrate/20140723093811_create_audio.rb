class CreateAudio < ActiveRecord::Migration
  def change
    create_table :audios do |t|
      t.string :url
      t.integer :publishable_flag, limit: 1
    end
  end
end
