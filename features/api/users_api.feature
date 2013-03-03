Feature: Users API
  # I need to be able to test my api for users.
  # I should be able to get a list of users.
  Background:
    Given I send and accept JSON
    And I exist as a user
  Scenario: Get complete users list
    Then I send a GET request to "/api/users/get_users/device_id.json?"
    Then show me the response
    Then the response status should be "200"
    And the JSON response should have an array of "1" records
