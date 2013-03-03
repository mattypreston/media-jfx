def create_schedule
  @schedule ||= { :name => "Test Schedule" }
end

Given /^a set of schedules like this:$/ do |table|
  pending
end

Then /^I visit the schedules page$/ do
  visit '/schedules'
end

When /^I add a new schedule/ do
  create_schedule
  click_link "New"
  fill_in "schedule_name", :with => @schedule[:name]
  fill_in "schedule_content", :with => @schedule[:content]
  click_button "Create Schedule"
end

Then /^I should see that my new schedule has been added$/ do
  page.should have_content "Test Device 1"
  page.should have_content "Test Package 1"
end

Then /^I should see that my schedule has been added to my website/ do
  page.should have_content @schedule[:name]
  page.should have_content @schedule[:content]
end