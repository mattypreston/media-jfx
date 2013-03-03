Feature: New Package
  As a registered user of the website
  I want to add a package to my website
  so I can show my packages on my packages page.

    Scenario: I sign in and add a new package to my website
      Given I am logged in
      Then I visit the packages page
      Then I add a new package
      Then I should see that my new package has been added
      When I sign out
      Then I should see a signed out message