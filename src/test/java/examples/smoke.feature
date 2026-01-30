
@allTests @smoke
Feature:  Smoke Tests

  Background:
    * configure ssl = true
    * url baseUrl
    * def utils = call read('classpath:examples/utils/functions.js')

  @high
  Scenario: Create new booking with valid data (date, destination, origin, userId)
    * def payload = read('classpath:examples/bookings/payloads/create-booking-valid.json')
    Given path 'booking'
    And request payload
    When method post
    Then status 201


  @high
  Scenario: Get the list of all bookings by userId and date
    Given path 'booking'
    And param userId = 1
    And param date = '2026-01-26'
    When method get
    Then status 200
    And match response == '#[]'



  @high
  Scenario: Get booking details by booking id
    Given path 'booking', 1
    When method get
    Then status 200
    And match response.id == 1


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
