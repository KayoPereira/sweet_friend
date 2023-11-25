class CreateDrawsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :draws do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end

    add_index :draws, [:user_id, :event_id], unique: true
  end
end
