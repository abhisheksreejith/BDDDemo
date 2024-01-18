@otp
Feature: 02-OTP
 Scenario Outline: Entered Wrong OTP
  Given I am on the OTP screen
  When I enter otp as "<otp>"
  And I click on Verify button
  Then I should say invalid OTP
 Examples:
      | otp   |
      | 12390 |
  
 Scenario: Entered Correct OTP
  Given I am on the OTP screen
  When I enter otp as "12345"
  And I click on Verify button
  Then I should say valid OTP

