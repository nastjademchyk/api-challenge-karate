@allTests @negative @functional
Feature: Users

Background:
  * configure ssl = true
  * url baseUrl
  * def utils = call read('classpath:examples/utils/functions.js')

  Scenario: Cannot create user without email
    Given path 'user'
    And request { name: 'Chelsia', surname: 'Demchyk' }
    When method post
    Then status 400

    Scenario: User with given Id not found
      Given path 'user', 189
      When method get
      Then status 404

  Scenario: User with given email exists already
    * def email = utils.randomEmail()
    Given path 'user'
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
    Given path 'user'
    And header Content-Type = 'application/json'
    And request
      """
      {
        "email":  '#(email)',
        "name": "John",
        "surname": "Doe"
      }
      """
    When method post
    Then status 409


