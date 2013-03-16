Feature: New Asset
  As a registered user of the website
  I want to add a asset to my website
  so I can show my assets on my packages page.

    Scenario: I sign in and add a new asset to my website
      Given I am logged in
      Then I visit the assets page
      Given the following Packages exist
          | name        |
          | Test Package 1 |
      Then I add a new asset
      Then I should see that my new asset has been added
      When I sign out
      Then I should see a signed out message