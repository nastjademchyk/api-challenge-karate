# API Testing Project with Karate Framework

This project contains automated tests written in Karate Framework for the application BookingApp, which exposes a REST API for managing users and bookings.

### API Overview
Endpoints for managing User operations
```bash
POST  /user      - Create a new user
GET   /user       - Get all users
GET   /user/{id}  - Get user
```
Endpoints for managing Booking operations

```bash
POST  /booking       - Create booking
GET   /booking       - Get bookings
GET   /booking/{id}  - Get booking
```
## Application setup instructions

The following steps describe how to run the BookingApp API inside GitHub Codespaces, which is required to execute the Karate tests.


**1. Create a Codespace**
- Go to: https://github.com/codespaces
- Create a new Codespace using this repository
-  Wait for the environment to load

**2. Make sure the Docker image is available**
- The file api_testing_service_latest.tar.xz must exist in the repository.

**3. Load the Docker image**
- In terminal to load Image use: docker load -i api_testing_service_latest.tar.xz

**4. To run application**

- In terminal use: docker run -d -p 8900:8900 --name apiservice api_testing_service

**5. Make the API publicly accessible**
- Open Ports tab
- Locate port 8900
- Set Visibility → Public

**6. Update baseUrl for Karate tests**
- Each Codespace instance generates a unique application URL.
  Make sure to update the baseUrl with your own URL in karate-config.js

**7. Open Swagger documentation**
- Use your Codespaces application URL and append /docs to access Swagger UI, which displays the full API documentation: https://your-application-url/docs


## Test Prioritization & Tagging
Tests are organized using Karate tags, allowing selective execution.

- @smoke: Critical path tests verifying core functionality
- @functional: All functional tests
- @positive: Tests with valid inputs expecting successful responses
- @negative: Tests with invalid inputs verifying proper error handling
- @security: Tests verifying security aspects of the API


Tests are also prioritized with tags:

- @high: Critical tests that must pass
- @medium: Important but not critical tests
- @low: Edge cases and less critical scenarios


## Running Tests

### Prerequisites
Java and Maven installed

### Running All Tests: 
```bash
mvn clean test -Dkarate.env=local -Dkarate.options="--tags @allTests"
```

### Running Tests by Tag
```bash
# Run only smoke tests
mvn clean test -Dkarate.env=local -Dkarate.options="--tags @smoke"

# Run only functional tests
mvn clean test -Dkarate.env=local -Dkarate.options="--tags @functional"

#Run only positive tests
mvn clean test -Dkarate.env=local -Dkarate.options="--tags @positive"

#Run only negative tests
mvn clean test -Dkarate.env=local -Dkarate.options="--tags @negative"

# Run only security tests
mvn clean test -Dkarate.env=local -Dkarate.options="--tags @security"
```

### Running Tests by Priority
```bash
# Run high priority tests
mvn clean test -Dkarate.env=local -Dkarate.options="--tags @high"

# Run medium priority tests
mvn clean test -Dkarate.env=local -Dkarate.options="--tags @medium"

# Run low priority tests
mvn clean test -Dkarate.env=local -Dkarate.options="--tags @low"
```

### Running Tests on Different Environments

You can specify the target environment using the karate.env system property:
```bash
# Run tests against local environment (default)
mvn test -Dkarate.env=local

# Run tests against test environment
mvn test -Dkarate.env=test

# Run tests against acceptance environment
mvn test -Dkarate.env=acc

# Run tests against production environment
mvn test -Dkarate.env=prod
```


## Generating and Viewing Test Reports
### Generating Reports
The test report is automatically generated after each test run. You can explicitly generate it:
```bash
mvn clean test -Dkarate.env=local -Dkarate.options="--tags @allTests"
```
### Viewing Reports
After test execution, the HTML report will be available at:
```bash
target/karate-reports/karate-summary.html
```
Open this file in any web browser to view the detailed test execution results, including:

- Overall test summary 
- Test execution time 
- Pass/fail status for each scenario 
- Detailed request/response information for failed tests