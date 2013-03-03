FactoryGirl.define do
  factory :site do
    name 'Test Site'
    address_line_1 'Address Line 1'
    address_line_2 'Address Line 2'
    address_line_3 'Address Line 3'
    post_code 'AA1 5AA'
    county 'Lancashire'
    country 'England'
  end
end