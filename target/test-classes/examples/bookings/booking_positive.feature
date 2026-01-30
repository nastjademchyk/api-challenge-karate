
@allTests @positive
Feature: Booking Positive Tests

  Background:
    * configure ssl = true
    * url baseUrl
    * def utils = call read('classpath:examples/utils/functions.js')

@functional @medium
  Scenario Outline: Create booking with 2 valid IATA-like codes
    * def today = utils.currentDate()
    Given path 'booking'
    And request { date: "#(today)", destination: "<dest>", origin: "<orig>", userId: <userid> }
    When method post
    Then status 201

    Examples:
      | dest | orig | userid |
      | LWO  | KRK  | 1      |
      | WAW  | FRA  | 2      |


  @functional @medium
  Scenario: Create 2 booking with the same data
    * def payload = read('classpath:examples/bookings/payloads/create-booking-same-data.json')
    Given path 'booking'
    And request payload
    When method post
    Then status 201

    Given path 'booking'
    And request payload
    When method post
    Then status 201


  @functional @low
  Scenario: Create booking with identical origin and destination codes
    * def payload = read('classpath:examples/bookings/payloads/create-booking-same-destination-origin.json')
    Given path 'booking'
    And request payload
    When method post
    Then status 201

  @functional @high
Scenario: Create booking with a valid future date
  * def payload = read('classpath:examples/bookings/payloads/create-booking-future-date.json')
  Given path 'booking'
  And request payload
  When method post
  Then status 201