class CrateTableEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      ## Database authenticatable
      t.string :name, null: false, default: ""
      t.date :date, null: false

      t.timestamps null: false
    end
  end
end
