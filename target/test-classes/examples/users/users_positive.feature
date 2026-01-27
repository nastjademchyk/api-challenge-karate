
@allTests @positive
Feature: Users Positive Tests

  Background:
    * configure ssl = true
    * url baseUrl
    * def utils = call read('classpath:examples/utils/functions.js')

  @smoke @high
  Scenario: Get all users
    Given path 'user'
    When method get
    Then status 200
    And match response == '#[]'

  @smoke
  Scenario: Get user data by Id
    Given path 'user', 1
    When method get
    Then status 200
    And match response == { id: 1, name: 'John', surname: 'Doe', email: 'john.doe@wherever.com' }

  Scenario: Create new user with dynamically generated valid email
    * def email = utils.randomEmail()
    Given path 'user'
    And request { email: '#(email)', name: 'Chelsia', surname: 'Demchyk' }
    When method post
    Then status 201

  Scenario: Create user with explicit Accept and Content-Type headers
    * def email = utils.randomEmail()
    Given path 'user'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request
      """
      {
        "email": '#(email)',
        "name": "John",
        "surname": "Doe"
      }
      """
    When method post
    Then status 201

    Scenario: Verify user response schema structure is correct
      Given path 'user', 1
      When method get
      Then status 200
      And match response ==
        """
      {
      id: '#number',
      email: '#string',
      name:  '#string',
      surname: '#string'
      }
      """