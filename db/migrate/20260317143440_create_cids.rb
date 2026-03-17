class CreateCids < ActiveRecord::Migration[8.1]
  def change
    create_table :cids do |t|
      t.string :number
      t.text :description

      t.timestamps
    end
  end
end
