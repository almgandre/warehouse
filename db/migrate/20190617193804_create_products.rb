class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.numeric :price, null: false
      t.string :category, null: false

      t.timestamps
    end
  end
end
