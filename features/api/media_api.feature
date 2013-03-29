Feature: Media API
  # I need to be able to test my api for media packages.
  # I should be able to get a list of media packages.
  Background:
    Given I send and accept JSON
    And I exist as a user

  Scenario: Get packages for device
    Then I send a GET request to "/api/media/get_packages_for_device/1.json?"
    Then show me the response
    Then the response status should be "200"
    And the JSON response should have an array of "1" records
  Scenario: Get package
    Then I send a GET request to "/api/media/get_package/1.json?"
    Then show me the response
    Then the response status should be "200"
    And the JSON response should have an array of "1" records

  Scenario: Force schedule to be current
    Then I send a POST request to "/api/media/force_schedule_to_be_current/1.json?"
    Then show me the response
    Then the response status should be "200"
    And the JSON response should have an array of "1" records

  Scenario: Remove force flag from schedule
    Then I send a POST request to "/api/media/remove_force_flag_from_schedule/1.json?"
    Then show me the response
    Then the response status should be "200"
    And the JSON response should have an array of "1" records

  #Scenario: Check invalid device id response returns an error
  #  pending
  #Scenario: Check package has a status of live
  #  If they request a package but their account is frozen the app needs to know
  #  so it will stop working.


