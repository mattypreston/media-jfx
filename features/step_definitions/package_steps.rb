def create_package
  @package ||= { :content => "This is the article content which should be seen on the resume", :name => "Main Article" }
end

Given /^a set of packages like this:$/ do |table|
  pending
end

Then /^I visit the packages page$/ do
  visit '/packages'
end

When /^I add a new package/ do
  create_package
  click_link "New"
  fill_in "package_name", :with => @package[:name]
  fill_in "package_content", :with => @package[:content]
  click_button "Create Package"
end

Then /^I should see that my new package has been added$/ do
  page.should have_content @package[:name]
  page.should have_content @package[:content]
end

Then /^I should see that my package has been added to my website/ do
  page.should have_content @package[:name]
  page.should have_content @package[:content]
end