@allTests @smoke
Feature: Users Positive Tests

  Background:
    * configure ssl = true
    * url baseUrl
    * def utils = call read('classpath:examples/utils/functions.js')


  @high
  Scenario: Create new user with valid data
    * def payload = read('classpath:examples/users/payloads/create-user-valid.json')
    Given path 'user'
    And request payload
    When method post
    Then status 201


  @high
  Scenario: Get all users
    Given path 'user'
    When method get
    Then status 200
    And match response == '#[]'

@high
  Scenario: Get user data by Id
  * def expected = read('classpath:examples/users/payloads/expected-user.json')
    Given path 'user', 1
    When method get
    Then status 200
    And match response == expected

