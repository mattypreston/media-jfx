class Device < ActiveRecord::Base
  belongs_to :site
  has_many :schedules

  attr_accessible :name, :serial_number, :site_id

end
