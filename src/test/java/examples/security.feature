@allTests @security
Feature: Security Tests

  Background:
    * configure ssl = true
    * url baseUrl
    * def utils = call read('classpath:examples/utils/functions.js')

  @medium
  Scenario Outline: Booking endpoint rejects unsupported HTTP methods
    Given path 'booking'
    When method <method>
    Then status 404

    Examples:
      | method |
      | delete |
      | put    |
      | patch  |

  @medium
  Scenario: Create booking with invalid Content-Type
    Given path 'booking'
    And header Content-Type = 'text/plain'
    And request 'not json'
    When method post
    Then status 400

  @high
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

  @medium
  Scenario: Reject unknown fields in create booking
    * def payload = read('classpath:examples/bookings/payloads/booking-unknown-field.json')
    Given path 'booking'
    And header Content-Type = 'application/json'
    And request payload
    When method post
    Then status 400

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
    * def payload = read('classpath:examples/users/payloads/create-user-large-payload.json')
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
