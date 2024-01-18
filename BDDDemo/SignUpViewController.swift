//
//  SignUpViewController.swift
//  BDDDemo
//
//  Created by Abhishek C Sreejith on 27/02/24.
//

import UIKit
import Amplify

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        guard let username = usernameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              let name = nameTextField.text else { return }
        Task {
            do {
                try await signUp(name: name, username: username, password: password, email: email)
            } catch {
                print("Error signing out:", error)
            }
        }
    }
    
    
    func signUp(name: String, username: String, password: String, email: String) async throws {
        let userAttributes = [
            AuthUserAttribute(.email, value: email),
            AuthUserAttribute(.name, value: name)
        ]
        
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        
        do {
            let signUpResult = try await Amplify.Auth.signUp(username: username, password: password, options: options)
            switch signUpResult.nextStep {
            case .done:
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                guard let OTPVC = storyBoard.instantiateViewController(withIdentifier: "OtpScreenViewController") as? OtpScreenViewController else { return }
                OTPVC.username = username
                self.navigationController?.pushViewController(OTPVC, animated: true)
                print("Sign up succeeded")
                
            case .confirmUser(let details, _, _):
                if let authCodeDetails = details {
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    guard let OTPVC = storyBoard.instantiateViewController(withIdentifier: "OtpScreenViewController") as? OtpScreenViewController else { return }
                    OTPVC.username = username
                    self.navigationController?.pushViewController(OTPVC, animated: true)
                    print("Confirm sign up with code: \(authCodeDetails.destination)")
                } else {
                    print("Confirm sign up with code: Unknown")
                }
            }
        } catch {
            print("Error signing up:", error)
        }
    }
    
}
