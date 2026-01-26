
@allTests @positive
Feature: Users

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
  Scenario: Get the user by Id
    Given path 'user', 1
    When method get
    Then status 200
    And match response contains { id: 1 }
    And match response.name == 'John'


  Scenario: Create new user with valid email address
    * def email = utils.randomEmail()
    Given path 'user'
    And request { email: '#(email)', name: 'Chelsia', surname: 'Demchyk' }
    When method post
    Then status 201

  Scenario: Accept header
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

    Scenario: Get user by Id and it returns correct schema
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