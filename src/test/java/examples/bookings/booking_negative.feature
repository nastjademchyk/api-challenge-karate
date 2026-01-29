
@allTests @negative
Feature: Booking Negative Tests

  Background:
    * configure ssl = true
    * url baseUrl
    * def utils = call read('classpath:examples/utils/functions.js')


  @high
  Scenario: Cannot create booking for a non-existing user
    * def payload = read('classpath:examples/bookings/payloads/non-existing-user.json')
    Given path 'booking'
    And request payload
    When method post
    Then status 404


  @medium
  Scenario: Cannot create booking with wrong data formatting
    * def payload = read('classpath:examples/bookings/payloads/create-booking-wrong-data-format.json')
    Given path 'booking'
    And request payload
    When method post
    Then status 400

@high
  Scenario: Reject booking creation when origin or destination is provided as full city names instead of 3‑letter airport codes
  * def payload = read('classpath:examples/bookings/payloads/create-booking-full-city-names.json')
      Given path 'booking'
      And request payload
      When method post
      Then status 400

@high
  Scenario: Reject booking creation when origin or destination is provided in lower case
  * def payload = read('classpath:examples/bookings/payloads/create-booking-lowercase-airport-codes.json')
    Given path 'booking'
    And request payload
    When method post
    Then status 400

@high
  Scenario: Reject booking creation when origin or destination length is less than 3 characters
  * def payload = read('classpath:examples/bookings/payloads/create-booking-short-airport-codes.json')
    Given path 'booking'
    And request payload
    When method post
    Then status 400

  @heigh
  Scenario: Reject booking creation when userId is string
    * def payload = read('classpath:examples/bookings/payloads/create-booking-userid-string.json')
    Given path 'booking'
    And request payload
    When method post
    Then status 400

@high
  Scenario: Reject booking creation without origin field
  * def payload = read('classpath:examples/bookings/payloads/create-booking-missing-origin.json')
    Given path 'booking'
    And request payload
    When method post
    Then status 400

@high
  Scenario: Reject booking creation when date field is empty
    * def payload = read('classpath:examples/bookings/payloads/create-booking-empty-date.json')
    Given path 'booking'
    And request payload
    When method post
    Then status 400

@high
  Scenario: Reject booking creation when userId is negative
    * def payload = read('classpath:examples/bookings/payloads/create-booking-negative-userid.json')
    Given path 'booking'
    And request payload
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


