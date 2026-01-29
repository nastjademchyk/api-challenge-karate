@allTests @negative
Feature: Users Negative Tests

Background:
  * configure ssl = true
  * url baseUrl
  * def utils = call read('classpath:examples/utils/functions.js')

  @high
  Scenario: Cannot create user without email
    * def payload = read('classpath:examples/users/payloads/create-user-missing-email.json')
    Given path 'user'
    And request payload
    When method post
    Then status 400

  @high
  Scenario: Cannot create user without surname
    * def payload = read('classpath:examples/users/payloads/create-user-missing-surname.json')
    Given path 'user'
    And request payload
    When method post
    Then status 400

@high
  Scenario: Cannot create user without name
  * def payload = read('classpath:examples/users/payloads/create-user-missing-name.json')
    Given path 'user'
    And request payload
    When method post
    Then status 400

  @high
  Scenario: Reject user creation when email value is numeric
    * def payload = read('classpath:examples/users/payloads/create-user-numeric-email.json')
    Given path 'user'
    And request payload
    When method post
    Then status 400

@high
  Scenario: Cannot create user if name value is not a string
  * def payload = read('classpath:examples/users/payloads/create-user-non-string-name.json')
    Given path 'user'
    And request payload
    When method post
    Then status 400

@medium
  Scenario: User with given Id not found
      Given path 'user', 189
      When method get
      Then status 404

@medium
  Scenario: User with given email exists already
  * def payload = read('classpath:examples/users/payloads/create-user-valid.json')
    Given path 'user'
    And header Content-Type = 'application/json'
    And request payload
    When method post
    Then status 201
    Given path 'user'
    And header Content-Type = 'application/json'
    And request payload
    When method post
    Then status 409

@high
Scenario: User cannot be created if the name field is empty
  * def payload = read('classpath:examples/users/payloads/create-user-empty-name.json')
  Given path 'user'
  And request payload
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

