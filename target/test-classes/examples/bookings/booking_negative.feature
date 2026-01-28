
@allTests @negative
Feature: Booking Negative Tests

  Background:
    * configure ssl = true
    * url baseUrl
    * def utils = call read('classpath:examples/utils/functions.js')


@high
  Scenario: Cannot create booking for a non-existing user
    Given path 'booking'
    And request { date: "2026-01-23", destination: "POL", origin: "USA", userId: 999}
    When method post
    Then status 404

  @medium
  Scenario: Cannot create booking with wrong data formatting
    Given path 'booking'
    And request { date: "02.02.2026", destination: "POL", origin: "USA", userId: 1}
    When method post
    Then status 400

@high @new
  Scenario: Reject booking creation when origin or destination is provided as full city names instead of 3‑letter airport codes
  * def date = utils.currentDate()
  * def destination = "Krakow"
  * def origin = "Ukraine"
  * def userId = 1
  * def payload = read('classpath:examples/bookings/payloads/create-booking-template.json')
      Given path 'booking'
      And request payload
      When method post
      Then status 400
@high
  Scenario: Reject booking creation when origin or destination is provided in lower case
    Given path 'booking'
    And request
        """
        {
          "date": "2026-01-26",
          "destination": "krk",
          "origin": "usa",
          "userId": 1
        }
        """
    When method post
    Then status 400

@high
  Scenario: Reject booking creation when origin or destination length is less than 3 characters
    Given path 'booking'
    And request
        """
        {
          "date": "2026-01-26",
          "destination": "KR",
          "origin": "PR",
          "userId": 1
        }
        """
    When method post
    Then status 400

  @heigh
  Scenario: Reject booking creation when userId is string
    Given path 'booking'
    And request
        """
        {
          "date": "2026-01-26",
          "destination": "KRA",
          "origin": "USA",
          "userId": "one"
        }
        """
    When method post
    Then status 400

@high
  Scenario: Reject booking creation without origin field
    Given path 'booking'
    And request
        """
        {
          "date": "2026-01-26",
          "destination": "KRA",
          "userId": 1
        }
        """
    When method post
    Then status 400

@high
  Scenario: Reject booking creation when date field is empty
    Given path 'booking'
    And request { date: "", destination: "KRA", origin: "USA", userId: 1 }
    When method post
    Then status 400

@high
  Scenario: Reject booking creation when userId is negative
    Given path 'booking'
    And request { date: "2026-01-26", destination: "KRA", origin: "USA", userId: -5 }
    When method post
    Then status 400

@high
  Scenario: Cannot create user with empty JSON object
    Given path 'booking'
    And request {}
    When method post
    Then status 400



@medium
  Scenario: Reject getting booking by id with non-numeric id
        Given path 'booking', "ABC"
        When method get
        Then status 400

@medium
  Scenario: Reject getting booking with wrong booking id
    Given path 'booking', 9999
    When method get
    Then status 404


@low
  Scenario: Reject providing bookings without userId
    Given path 'booking'
    And request { date: "2026-01-27"}
    When method get
    Then status 400

  @low
  Scenario: Reject providing bookings without date
    Given path 'booking'
    And request { userId: 1}
    When method get
    Then status 400


@medium
  Scenario: Reject providing bookings with wrong data formatting
    Given path 'booking'
    And request { date: "2026.01.27", userId: 1}
    When method get
    Then status 400


