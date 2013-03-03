Feature: New Site
  As a registered user of the website
  I want to add a site to my website
  so I can show my sites on my devices page.

    Scenario: I sign in and add a new site to my website
      Given I am logged in
      Then I visit the sites page
      Then I add a new site
      Then I should see that my new site has been added
      When I sign out
      Then I should see a signed out message