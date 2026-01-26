
@allTests @positive @functional
Feature: Booking

  Background:
    * configure ssl = true
    * url baseUrl
    * def utils = call read('classpath:examples/utils/functions.js')

    @smoke
  Scenario: Get the list of all bookings by userId and date
    Given path 'booking'
    And param userId = 1
    And param date = '2026-01-26'
    When method get
    Then status 200
    And match response == '#[]'



  @smoke @high
  Scenario: Get the list of all bookings by userID
    Given path 'booking', 1
    When method get
    Then status 200
    And match response contains { id: 1 }

    @smoke
  Scenario: Create new booking with valid data
    * def today = utils.currentDate()
    Given path 'booking'
    And request { date: "#(today)", destination: "USA", origin: "KRK", userId: 1 }
    When method post
    Then status 201


