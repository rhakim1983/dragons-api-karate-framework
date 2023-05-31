@Regression 
Feature: Random Account Creation

  Background: Setup Test Generate Token
  
  * def tokenFeature = callonce read('GenerateToken.feature')
  * def token = tokenFeature.response.token 
      Given url "https://tek-insurance-api.azurewebsites.net"
  
  Scenario: Create Account with Random Email
  # Call Java Class and Method with Karate.
  * def dataGenerator = Java.type ('api.data.GenereteData')
  * def autoEmail = dataGenerator.getEmail()
   Given path "/api/accounts/add-primary-account"
   And header Authorization = "Bearer " + token
   And request
      """
      {
      "email": "#(autoEmail)",
      "firstName": "Ehsan",
      "lastName": "Hakim",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "IT",
      "dateOfBirth": "1990-09-23",
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail 
  
		
