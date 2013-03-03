# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    #device_id Device.all.first.id
    #package_id Package.all.first.id
    date_time Date.today.at_midnight
  end
end