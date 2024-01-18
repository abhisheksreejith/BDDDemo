//
//  LoginSteps.swift
//  BDDDemoUITests
//
//  Created by Abhishek-Sreejith on 18/01/24.
//
import Foundation
import Cucumberish

class LoginSteps {
    func LoginStepsImplementation() {
        Given("I am on the login screen") { _, _ in
            LoginSteps.waitForElementToAppear(XCUIApplication().otherElements["LoginView"])
        }
        When("I enter username as \"([^\\\"]*)\" and password as \"([^\\\"]*)\"") { args, _ in
            let argOne = args?[0]
            let app = XCUIApplication()
            let userNameTextField = app.textFields["usernameTextField"]
            userNameTextField.tap()
            userNameTextField.typeText(argOne ?? "" + "\n")
            let argTwo = args?[1]
            let passwordTextField = app.textFields["passwordTextField"]
            passwordTextField.tap()
            passwordTextField.typeText(argTwo ?? "" + "\n")
        }
        And("I click on Login Button") { _, _ in
            print("Login Button tapped")
            let app = XCUIApplication()
            let loginButton = app.buttons["loginButton"]
            loginButton.tap()
        }
        Then("Login was unsuccessful") { args, _ in
            let app = XCUIApplication()
            let errorMessage = app.staticTexts["Invalid Credentials"]
            if errorMessage.exists {
                print("Login failed")
            } else{
                XCTFail("Invalid user login test failed")
            }
        }
        Then("I should be logged in successfully") { args, _ in
            print("success")
            let app = XCUIApplication()
            let otpScreenText = app.staticTexts["Enter the OTP"]
            if otpScreenText.exists {
                print("sucess login")
            }
            else {
                XCTFail("valid user login failed")
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
