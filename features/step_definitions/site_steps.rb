def create_site
  @site ||= { :address_line_1 => "Address Line 1", :address_line_2 => "Address Line 2",
              :address_line_3 => "Address Line 3", :post_code => "AA1 5AA",
              :county => "Lancashire", :country => "England",
              :name => "Main Site" }
end

Given /^a set of sites like this:$/ do |table|
  pending
end

Then /^I visit the sites page$/ do
  visit '/sites'
end

When /^I add a new site/ do
  create_site
  click_link "New"
  fill_in "site_name", :with => @site[:name]
  fill_in "site_address_line_1", :with => @site[:address_line_1]
  fill_in "site_address_line_2", :with => @site[:address_line_2]
  fill_in "site_address_line_3", :with => @site[:address_line_3]
  fill_in "site_post_code", :with => @site[:post_code]
  fill_in "site_county", :with => @site[:county]
  fill_in "site_country", :with => @site[:country]
  click_button "Create Site"
end

Then /^I should see that my new site has been added$/ do
  page.should have_content @site[:name]
  page.should have_content @site[:address_line_1]
  page.should have_content @site[:address_line_2]
  page.should have_content @site[:address_line_3]
  page.should have_content @site[:post_code]
  page.should have_content @site[:county]
  page.should have_content @site[:country]
end

Then /^I should see that my site has been added to my website/ do
  page.should have_content @site[:name]
end