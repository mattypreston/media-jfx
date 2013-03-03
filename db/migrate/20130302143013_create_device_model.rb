class CreateDeviceModel < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.string :serial_number
      t.integer :site_id
      t.timestamps
    end
  end
end
