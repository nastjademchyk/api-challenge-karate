
@allTests @smoke @positive
Feature: Users

  Background:
    * configure ssl = true
    * url baseUrl
    * def utils = call read('classpath:examples/utils/functions.js')

  Scenario: Get all users
    Given path 'user'
    When method get
    Then status 200
    And match response == '#[]'

  Scenario: Get the user by ID
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

