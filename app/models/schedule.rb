class Schedule < ActiveRecord::Base

  belongs_to :device
  belongs_to :package

  attr_accessible :device_id, :package_id, :start_date_time, :end_date_time
end
