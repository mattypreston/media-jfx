class Device < ActiveRecord::Base
  belongs_to :site
  attr_accessible :name, :serial_number, :site_id

end
