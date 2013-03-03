class Package < ActiveRecord::Base
  has_many :schedules
  attr_accessible :name, :fxml
end
