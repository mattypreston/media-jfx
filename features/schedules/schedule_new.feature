Feature: New Schedule
  As a registered user of the website
  I want to add a schedule to my website
  so I can show my schedules on my package page.

    Scenario: I sign in and add a new schedule to my website
      Given I am logged in
      Then I visit the schedules page
      Then I add a new schedule
      Then I should see that my new schedule has been added
      When I sign out
      Then I should see a signed out message