class AddDrawnUserToDraws < ActiveRecord::Migration[7.0]
  def change
    add_reference :draws, :drawn_user, null: true, foreign_key: { to_table: :users }
    add_column :draws, :was_drawn, :boolean, null: false, default: false
  end
end
