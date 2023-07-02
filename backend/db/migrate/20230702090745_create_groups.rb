class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.integer :count
      t.string :name
      t.string :photo
      t.string :background

      t.timestamps
    end
  end
end
