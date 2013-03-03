Feature: New Schedule
  As a registered user of the website
  I want to add a schedule to my website
  so I can show my schedules on my package page.

    Scenario: I sign in and add a new schedule to my website
      Given I am logged in
      Then I visit the schedules page
      Given the following Sites exist
        | name        |
        | Test Site 1 |
      Given the following Devices exist
        | name          |
        | Test Device 1 |
      Given the following Packages exist
        | name          |
        | Test Package 1 |

      #Then I add a new device
      Then I click "New"
      Then I select "Test Device 1" from "schedule[device_id]"
      Then I select "Test Package 1" from "schedule[package_id]"
      #When I fill in "Name" with ""
      #When I fill in "Serial number" with ""
      When I press "Create Schedule"
      Then I should see that my new schedule has been added
      When I sign out
      Then I should see a signed out message