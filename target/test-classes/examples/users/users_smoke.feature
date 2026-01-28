@allTests @smoke
Feature: Users Positive Tests

  Background:
    * configure ssl = true
    * url baseUrl


@high
  Scenario: Get all users
    Given path 'user'
    When method get
    Then status 200
    And match response == '#[]'

@high
  Scenario: Get user data by Id
    Given path 'user', 1
    When method get
    Then status 200
    And match response == { id: 1, name: 'John', surname: 'Doe', email: 'john.doe@wherever.com' }

