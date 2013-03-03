# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    device_id 1
    package_id 1
    start_date_time "2013-03-03 15:34:59"
    end_date_time "2013-03-03 15:34:59"
  end
end
