class CreateScheduleModel < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :device_id
      t.integer :package_id
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.timestamps
    end
  end
end
