Feature: New Device
  As a registered user of the website
  I want to add a device to my website
  so I can show my devices on my package page.



  Scenario: I sign in and add a new device to my website
    Given I am logged in
    Then I visit the devices page
    Given the following Sites exist
        | name        |
        | Test Site 1 |
    #Then I add a new device
    Then I click "New"
    Then I select "Test Site 1" from "device[site_id]"
    #When I fill in "Name" with ""
    #When I fill in "Serial number" with ""
    When I press "Create Device"
    Then I should see that my new device has been added
    When I sign out
    Then I should see a signed out message

  Scenario: I try and add a device with no sites to select
    Given I am logged in
    Then I visit the devices page
    Then I try to add a new device
    Then I should see a no sites set up message
