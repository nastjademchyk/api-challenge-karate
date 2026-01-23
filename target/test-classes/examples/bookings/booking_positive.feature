
@allTests @smoke @positive @functional @high
Feature: Booking

  Background:
    * configure ssl = true
    * url baseUrl
    * def utils = call read('classpath:examples/utils/functions.js')


#  Scenario: Get the list of all bookings
#    Given path 'booking'
#    When method get
#    Then status 200
#    And match response == '#[]'



  Scenario: Get the list of all bookings by userID
    Given path 'booking', 1
    When method get
    Then status 200
    And match response contains { id: 1 }

  Scenario: Create new booking with valid data
    * def today = utils.currentDate()
    Given path 'booking'
    And request { date: "#(today)", destination: "USA", origin: "KRK", userId: 1 }
    When method post
    Then status 201


