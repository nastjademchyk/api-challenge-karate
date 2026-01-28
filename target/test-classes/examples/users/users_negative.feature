@allTests @negativ
Feature: Users Negative Tests

Background:
  * configure ssl = true
  * url baseUrl
  * def utils = call read('classpath:examples/utils/functions.js')

  @high
  Scenario: Cannot create user without email
    Given path 'user'
    And request { name: 'Chelsia', surname: 'Demchyk' }
    When method post
    Then status 400

  @high
  Scenario: Cannot create user without surname
    * def email = utils.randomEmail()
    Given path 'user'
    And request { email: '#(email)', name: 'Chelsia',  }
    When method post
    Then status 400

@name
  Scenario: Cannot create user without name
    * def email = utils.randomEmail()
    Given path 'user'
    And request { email: '#(email)', surname: 'Demchyk'  }
    When method post
    Then status 400

  @high
  Scenario: Reject user creation when email value is numeric
    Given path 'user'
    And request { email: 12345, name: 'Chelsia', surname: 'Demchyk'  }
    When method post
    Then status 400

@high
  Scenario: Cannot create user if name value is not a string
    * def email = utils.randomEmail()
    Given path 'user'
    And request { email: '#(email)',  name: 1234, surname: 'Demchyk'  }
    When method post
    Then status 400

@medium
  Scenario: User with given Id not found
      Given path 'user', 189
      When method get
      Then status 404

@medium
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

@high
Scenario: User cannot be created if the name field is empty
  * def email = utils.randomEmail()
  Given path 'user'
  And request
      """
      {
        "email":  '#(email)',
        "name": "",
        "surname": "Demchyk"
      }
      """
  When method post
  Then status 400

@medium
  Scenario: User returns 400 for invalid (non‑numeric) id
    Given path 'user', 'abc'
    When method get
    Then status 400

@high
Scenario: Cannot create user with empty JSON object
  Given path 'user'
  And request {}
  When method post
  Then status 400

