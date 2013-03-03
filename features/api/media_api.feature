Feature: Media API
  # I need to be able to test my api for media packages.
  # I should be able to get a list of media packages.
  Background:
    Given I send and accept JSON
    And I exist as a user

  Scenario: Get packages for device
    Then I send a GET request to "/api/media/get_fxml/1.json?"
    Then show me the response
    Then the response status should be "200"
    And the JSON response should have an array of "1" records