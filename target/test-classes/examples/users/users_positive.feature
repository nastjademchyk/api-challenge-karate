
@allTests @positive
Feature: Users Positive Tests

  Background:
    * configure ssl = true
    * url baseUrl
    * def utils = call read('classpath:examples/utils/functions.js')
    * def name = "Alex"
    * def surname = "Smith"



  @functional @medium
  Scenario: Create new user with dynamically generated valid email
    * def email = utils.randomEmail()
    * def payload = read('classpath:examples/users/payloads/create-user-template.json')
    Given path 'user'
    And request payload
    When method post
    Then status 201

  @functional @medium
  Scenario: Create user with explicit Accept and Content-Type headers
    * def email = utils.randomEmail()
    * def payload = read('classpath:examples/users/payloads/create-user-template.json')
    Given path 'user'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request payload
    When method post
    Then status 201


  @functional @medium
    Scenario: Verify user response schema structure is correct
    * def schema = read('classpath:examples/users/schemas/user-response-schema.json')
      Given path 'user', 1
      When method get
      Then status 200
      And match response == schema