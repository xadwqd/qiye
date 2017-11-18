class CreateStations < ActiveRecord::Migration[5.0]
  def change
    create_table :stations do |t|

      t.string :name
      t.boolean :is_del, default: false
      t.references :city


      t.timestamps
    end
  end
end
