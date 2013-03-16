def create_asset
  @asset ||= { :name => "Test Asset" }
end

Given /^a set of assets like this:$/ do |table|
  pending
end

Then /^I visit the assets page$/ do
  visit assets_path
end

When /^I add a new asset/ do
  create_asset
  click_link "New"
  fill_in "asset_name", :with => @asset[:name]
  click_button "Create Asset"
end

Then /^I should see that my new asset has been added$/ do
  #page.should have_content "Test package 1"
  page.should have_content "Test Asset"
end

