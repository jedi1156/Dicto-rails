class CreateWordSets < ActiveRecord::Migration
  def up
    create_table :word_sets do |t|
      t.string :name, null: false
    end
  end

  def down
    drop_table :word_sets
  end
end
