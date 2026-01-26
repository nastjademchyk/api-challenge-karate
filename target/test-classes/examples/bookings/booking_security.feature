@allTests @security
Feature: Booking Security

  Background:
    * configure ssl = true
    * url baseUrl
    * def utils = call read('classpath:examples/utils/functions.js')


  Scenario Outline: Booking endpoint rejects unsupported HTTP methods
    Given path 'booking'
    When method <method>
    Then status 404

Examples:
  | method |
  | delete |
  | put    |
  | patch  |


  Scenario: Create booking with invalid Content-Type
    Given path 'booking'
    And header Content-Type = 'text/plain'
    And request 'not json'
    When method post
    Then status 400


  Scenario:  Security headers validation for booking detail endpoint by Id
    Given path 'booking', 1
    When method get
    Then status 200
      And match header x-content-type-options == 'nosniff'
      And match header strict-transport-security == 'max-age=31536000; includeSubDomains'
      And match header cache-control == 'no-cache,no-store'
      And match header pragma == 'no-cache'
      And match header referrer-policy == 'same-origin'
      And match header x-robots-tag == 'noindex, nofollow'


  Scenario: Reject unknown fields in create booking
    Given path 'booking'
    And header Content-Type = 'application/json'
    And request
      """
      {
        "date": "2026-01-26",
        "destination": "LWO",
        "origin": "KRK",
        "name": "Max",
        "iserId": "1"
      }
      """
    When method post
    Then status 400
