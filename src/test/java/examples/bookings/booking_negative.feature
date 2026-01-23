
@allTests @smoke @functional @negative
Feature: Booking

  Background:
    * configure ssl = true
    * url baseUrl


  Scenario: Cannot create booking for a non-existing user
    Given path 'booking'
    And request { date: "2026-01-23", destination: "POL", origin: "USA", userId: 999}
    When method post
    Then status 404
