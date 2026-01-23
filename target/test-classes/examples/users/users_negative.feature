@allTests @negative @functional
Feature: Users

Background:
  * configure ssl = true
  * url baseUrl

  Scenario: Cannot create user without email
Given path 'user'
And request { name: 'Chelsia', surname: 'Demchyk' }
When method post
Then status 400
