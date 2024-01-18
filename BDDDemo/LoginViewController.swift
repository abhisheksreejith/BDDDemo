//
//  ViewController.swift
//  BDDDemoApp
//
//  Created by Abhishek-Sreejith on 16/01/24.
//

import UIKit
import Amplify
class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet var loginView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        usernameTextField.accessibilityIdentifier = "usernameTextField"
        passwordTextField.accessibilityIdentifier = "passwordTextField"
        loginButton.accessibilityIdentifier = "loginButton"
        errorMessage.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text else {
                errorMessage.isHidden = false
                return }
        self.view.showLoader()
        
        Task {
            do {
                try await signIn(username: username, password: password)
            } catch {
                self.view.hideLoader()
                let alert = UIAlertController(title: "Error Logging In",
                                              message: "Try again later.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
            }
        }
    }
    
    @IBAction func signupButtonPressed(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let signupVC = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        else { return }
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        Task {
            do {
                try await signOut()
            } catch {
                print("Error signing out:", error)
            }
        }
    }
    func signIn(username: String, password: String) async throws {
        let signInResult = try await Amplify.Auth.signIn(
            username: username,
            password: password
        )
        if signInResult.isSignedIn {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            guard let homescreenVC = storyBoard.instantiateViewController(withIdentifier: "HomeScreenViewController") as? HomeScreenViewController
            else { return }
            self.navigationController?.pushViewController(homescreenVC, animated: true)
            print("Sign in succeeded")
        } else {
            self.view.hideLoader()
            print("Sign in failed")
            errorMessage.isHidden = false
            usernameTextField.text = ""
            passwordTextField.text = ""
        }
    }
    func signOut() async throws {
        _ =  try await Amplify.Auth.signOut()
        print("Sign out succeeded")
        
    }
    
}
