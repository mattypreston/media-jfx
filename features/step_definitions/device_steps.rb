def create_device
  @device ||= { :serial_number => "12345670", :name => "Main Device", :site_id => 1 }
end

Given /^a set of devices like this:$/ do |table|
  pending
end

Given /^the following Sites exist$/ do |table|
  table.hashes.each do |attributes|
    Site.create :name => attributes[:name]
  end
end

Then /^I visit the devices page$/ do
  visit '/devices'
end

When /^I try to add a new device/ do
  click_link "New"
end

When /^I add a new device/ do
  create_device
  click_link "New"
  fill_in "device_name", :with => @device[:name]
  fill_in "device_serial_number", :with => @device[:serial_number]

  fill_in "device_site_id", :with => @device[:site_id]
  click_button "Create Device"
end

When /^I click "(.*?)"/ do |value|
  click_link "#{value}"
end

When /^I press "(.*?)"/ do |value|
  click_button "#{value}"
end


When /^I select "(.*?)" from "(.*?)"$/ do |option, field|
  page.select option, :from => field
end

Then /^I should see that my new device has been added$/ do
  page.should have_content "Test Site 1"
end

Then /^I should see that my device has been added to my website/ do
  page.should have_content @device[:name]
  page.should have_content @device[:serial_number]
end

Then /^I should see a no sites set up message$/ do
  page.should have_content "There are no sites currently set up."
end