class CreateSpaces < ActiveRecord::Migration[6.0]
  def change
    create_table :spaces do |t|
      t.string :title
      t.string :address
      t.references :user, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
