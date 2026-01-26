@allTests @security

Feature: User Security

  Background:
    * configure ssl = true
    * url baseUrl
    * def utils = call read('classpath:examples/utils/functions.js')

  Scenario Outline: Users endpoint rejects unsupported HTTP methods
    Given path 'user'
    When method <method>
    Then status 404

    Examples:
      | method |
      | delete |
      | put    |
      | patch  |


  Scenario: User endpoint rejects invalid Content-Type
    Given path 'user'
    And header Content-Type = 'text/plain'
    And request 'not json'
    When method post
    Then status 400


    Scenario: API safely rejects large payload by creating a new user
      * def large = 'X'.repeat(1000000)
      * def email = utils.randomEmail()
      Given path 'user'
      And header Content-Type = 'application/json'
      And request { email: '#(email)', name: '#(large)', surname: 'Demchyk' }
      When method post
      Then status 413

    Scenario: User list must not expose sensetive information: token, apiKey, sessionId, password
      Given path 'user'
      When method get
      Then status 200
        * string responseString = response
      And match responseString !contains '"token"'
      And match responseString !contains '"apiKey"'
      And match responseString !contains '"sessionId"'
      And match responseString !contains '"password"'
