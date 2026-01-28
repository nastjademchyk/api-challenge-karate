@allTests @security

Feature: User Security Tests

  Background:
    * configure ssl = true
    * url baseUrl
    * def utils = call read('classpath:examples/utils/functions.js')
    * def schema = read('classpath:examples/users/payloads/user-response-schema.json')

  @medium
  Scenario Outline: Users endpoint rejects unsupported HTTP methods
    Given path 'user'
    When method <method>
    Then status 404

    Examples:
      | method |
      | delete |
      | put    |
      | patch  |

@medium
  Scenario: User endpoint rejects invalid Content-Type
    Given path 'user'
    And header Content-Type = 'text/plain'
    And request 'not json'
    When method post
    Then status 400

@medium
    Scenario: API safely rejects large payload by creating a new user
      * def large = 'X'.repeat(1000000)
      * def email = utils.randomEmail()
      * def name = large
      * def surname = 'Demchyk'
      * def payload = read('classpath:examples/users/payloads/create-user-template.json')

      Given path 'user'
      And header Content-Type = 'application/json'
      And request payload
      When method post
      Then status 413

  @high
    Scenario: User list must not expose sensitive information: token, apiKey, sessionId, password
      Given path 'user'
      When method get
      Then status 200
        * string responseString = response
      And match responseString !contains '"token"'
      And match responseString !contains '"apiKey"'
      And match responseString !contains '"sessionId"'
      And match responseString !contains '"password"'
