#Scenario 10:
#Endpoint = /api/accounts/add-primary-account.
#Status Code = 201
#Assert Email Address
#Notes:
#duplicate email not accepted
#For Gender and maritalStatus you have to use the Predefind values.
#Once you create Account validate database and take screenshot.
#FirstName and LastName should be your name.
#In Request body we don't need id and isNew field (you can remove them).
@Regression 
Feature: Create Account Test

  Background: API Test Setup
    #callonce read is Karate Step to execute and read another feature file.
    #the result of callonce can store into new variable using def step.
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create Account
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      {
      "email": "ehsan.hakim2@gmail.com",
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
		And assert response.email == "ehsan.hakim2@gmail.com"
		#Delete created account 
		Given path "/api/accounts/delete-account"
		And header Authorization = "Bearer " + generatedToken
		And param primaryPersonId = response.id 
		When method delete
		Then status 200
		And print response
		And assert response == "Account Successfully deleted"
		
		
		
		
		