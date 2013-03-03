# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :package do
    name 'Test Package Name'
    fxml '<FXML></FXML>'
  end
end