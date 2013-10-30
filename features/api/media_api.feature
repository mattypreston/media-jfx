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

  Scenario: Post a media file and create an asset
    When I send a POST request to "/api/media/add_asset_to_package/1.json?" with the following:
    """
    { "assets": [
                  {
                    "asset_file": "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAIAAADYYG7QAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYxIDY0LjE0MDk0OSwgMjAxMC8xMi8wNy0xMDo1NzowMSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNS4xIFdpbmRvd3MiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NTAzMkM4MDBENzMzMTFFMkFCOUNDQzAzRUYxRUIwM0UiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NTAzMkM4MDFENzMzMTFFMkFCOUNDQzAzRUYxRUIwM0UiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo1MDMyQzdGRUQ3MzMxMUUyQUI5Q0NDMDNFRjFFQjAzRSIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo1MDMyQzdGRkQ3MzMxMUUyQUI5Q0NDMDNFRjFFQjAzRSIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/Pj53tQIAAAeCSURBVHja7FhrbBxH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",
                    "file_name" : "test.png",
                    "file_type" : "png"
                  }
                ]
    }
    """
    Then show me the response
    Then the response status should be "200"
    And the JSON response should have an array of "1" records
    Then I should have "1" assets for this package with id of "1"

  Scenario: Create a package with assets
    When I send a POST request to "/api/media/add_new_package.json?" with the following:
    """
        {
          "name": "My New Package",
          "fxml": "",
          "assets": [
                      {
                        "asset_file": "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAIAAADYYG7QAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYxIDY0LjE0MDk0OSwgMjAxMC8xMi8wNy0xMDo1NzowMSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNS4xIFdpbmRvd3MiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NTAzMkM4MDBENzMzMTFFMkFCOUNDQzAzRUYxRUIwM0UiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NTAzMkM4MDFENzMzMTFFMkFCOUNDQzAzRUYxRUIwM0UiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo1MDMyQzdGRUQ3MzMxMUUyQUI5Q0NDMDNFRjFFQjAzRSIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo1MDMyQzdGRkQ3MzMxMUUyQUI5Q0NDMDNFRjFFQjAzRSIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/Pj53tQIAAAeCSURBVHja7FhrbBxH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",
                        "file_name" : "test.png",
                        "file_type" : "png"
                      }
                    ]
        }
        """
    Then show me the response
    Then the response status should be "200"
    And the JSON response should have an array of "1" records
    Then I should have "1" package with the name of "My New Package"

#Scenario: Check invalid device id response returns an error
  #  pending
  #Scenario: Check package has a status of live
  #  If they request a package but their account is frozen the app needs to know
  #  so it will stop working.


