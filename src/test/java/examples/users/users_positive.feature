
@allTests @positive
Feature: Users Positive Tests

  Background:
    * configure ssl = true
    * url baseUrl
    * def utils = call read('classpath:examples/utils/functions.js')


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


  @functional @medium
    Scenario: Create user with name and surname in lowercase
      * def payload = read('classpath:examples/users/payloads/create-user-lowercase.json')
      Given path 'user'
      And request payload
      When method post
      Then status 201

  @functional @medium
  Scenario: Create user with name and surname in uppercase
    * def payload = read('classpath:examples/users/payloads/create-user-uppercase.json')
    Given path 'user'
    And request payload
    When method post
    Then status 201

  @functional @low
Scenario: Create new user with whitespaces at the beginning and at the end of name and surname
  * def payload = read('classpath:examples/users/payloads/create-user-with-whitespaces.json')
  Given path 'user'
  And request payload
  When method post
  Then status 201

  @functional @medium
  Scenario:Create a new user with first name and surname written in the cyrillic alphabet
      * def payload = read('classpath:examples/users/payloads/create-user-in-cyrillic.json')
      Given path 'user'
      And request payload
      When method post
      Then status 201

  @functional @low
  Scenario: Create a new user with special characters in the first name and surname
    * def payload = read('classpath:examples/users/payloads/create-user-with-special-characters.json')
    Given path 'user'
    And request payload
    When method post
    Then status 201
