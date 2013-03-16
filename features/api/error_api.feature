Feature: Error API
  # I need to be able to receive error notifications from media packages.
  # I should be able to get a list of media packages.
  Background:
    Given I send and accept JSON
    And I exist as a user

  Scenario: Post error
    Then I send a POST request to "/api/error/post_error/1.json?"
    Then show me the response
    Then the response status should be "200"
    And the JSON response should have an array of "1" records
  #Scenario: Check invalid device id response returns an error
  #  pending