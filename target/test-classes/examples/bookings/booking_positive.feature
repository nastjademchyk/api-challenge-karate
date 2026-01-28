
@allTests @positive
Feature: Booking Positive Tests

  Background:
    * configure ssl = true
    * url baseUrl
    * def utils = call read('classpath:examples/utils/functions.js')

@functional @medium
  Scenario Outline: Create booking with various valid IATA-like codes
    * def today = utils.currentDate()
    Given path 'booking'
    And request { date: "#(today)", destination: "<dest>", origin: "<orig>", userId: <userid> }
    When method post
    Then status 201

    Examples:
      | dest | orig | userid |
      | LWO  | KRK  | 1      |
      | WAW  | FRA  | 2      |
      | LHR  | CDG  | 3      |
      | JFK  | LAX  | 4      |

