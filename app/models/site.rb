class Site < ActiveRecord::Base

  has_many :devices

  attr_accessible :name, :address_line_1, :address_line_2, :address_line_3, :post_code,
                  :county, :country

end
