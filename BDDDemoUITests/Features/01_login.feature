Feature: 01-UserLogin
 Scenario Outline: Unsuccessful Login
  Given I am on the login screen
  When I enter username as "<email>" and password as "<password>"
  And I click on Login Button
  Then Login was unsuccessful
 Examples:
      | email                       | password |
      | exampleEmail123@gmail.com   | 1234567  |

 Scenario: Successful Login
  Given I am on the login screen
  When I enter username as "abhishek@gmail.com" and password as "123456"
  And I click on Login Button
  Then I should be logged in successfully

