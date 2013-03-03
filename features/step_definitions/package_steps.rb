def create_package

  @package ||= { :fxml => "<?xml version=\"1.0\" encoding=\"UTF-8\"?>

  <?import java.lang.*?>
  <?import java.util.*?>
  <?import javafx.scene.control.*?>
  <?import javafx.scene.layout.*?>
  <?import javafx.scene.paint.*?>

  <AnchorPane id=\"AnchorPane\" maxHeight=\"-Infinity\" maxWidth=\"-Infinity\" minHeight=\"-Infinity\" minWidth=\"-Infinity\" prefHeight=\"400.0\" prefWidth=\"600.0\" xmlns:fx=\"http://javafx.com/fxml\">
    <children>
      <Label layoutX=\"234.0\" layoutY=\"72.0\" prefHeight=\"178.0\" prefWidth=\"230.0\" text=\"Hello\" />
    </children>
  </AnchorPane>", :name => "Test Package" }
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
  fill_in "package_fxml", :with => @package[:fxml]
  click_button "Create Package"
end

Then /^I should see that my new package has been added$/ do
  page.should have_content @package[:name]
  page.should have_content @package[:fxml]
end

Then /^I should see that my package has been added to my website/ do
  page.should have_content @package[:name]
  page.should have_content @package[:fxml]
end