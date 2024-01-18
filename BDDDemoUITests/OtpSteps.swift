//
//  LoginSteps.swift
//  BDDDemoUITests
//
//  Created by Abhishek-Sreejith on 18/01/24.
//

import Foundation
import Cucumberish

class OtpSteps{
    func OtpStepsImplementation() {
        Given("I am on the OTP screen") { _, _ in
            OtpSteps.waitForElementToAppear(XCUIApplication().otherElements["OtpView"])
        }
        When("I enter otp as \"([^\\\"]*)\"") { args, _ in
            let argOne = args?[0]
            let app = XCUIApplication()
            let otpTextField = app.textFields["otpTextField"]
            otpTextField.tap()
            otpTextField.typeText(argOne ?? "" + "\n")
        }
        And("I click on Verify button") { args, _ in
            let app = XCUIApplication()
            let loginButton = app.buttons["verifyButton"]
            loginButton.tap()
        }
        Then("I should say invalid OTP") { args, _ in
            let app = XCUIApplication()
            let errorMessage = app.staticTexts["Invalid OTP. Try Again :("]
            if errorMessage.exists {
                print("OTP failed")
            } else {
                XCTFail("Invalid OTP test failed")
            }
        }
        Then("I should say valid OTP") { args, _ in
            let app = XCUIApplication()
            let alertMessage = app.staticTexts["User Logged In"]
            if alertMessage.exists {
                print("OTP successful")
            } else{
                XCTFail("Valid OTP test failed")
            }
        }
    }
    class func waitForElementToAppear(_ element: XCUIElement){
        let result = element.waitForExistence(timeout: 5)
        guard result else {
            XCTFail("Element does not appear")
            return
        }
    }
}

