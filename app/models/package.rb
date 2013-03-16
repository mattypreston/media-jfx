class Package < ActiveRecord::Base
  has_many :schedules
  has_many :assets
  attr_accessible :name, :fxml
end
