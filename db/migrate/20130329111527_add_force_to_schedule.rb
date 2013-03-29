class AddForceToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :force_flag, :boolean
  end
end
