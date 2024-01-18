//
//  ViewController.swift
//  BDDDemoApp
//
//  Created by Abhishek-Sreejith on 16/01/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        usernameTextField.accessibilityIdentifier = "usernameTextField"
        passwordTextField.accessibilityIdentifier = "passwordTextField"
        loginButton.accessibilityIdentifier = "loginButton"
        errorMessage.isHidden = true
        
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        if usernameTextField.text == "abhishek@gmail.com" && passwordTextField.text == "123456" {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            guard let OTPVC = storyBoard.instantiateViewController(withIdentifier: "OtpScreenViewController") as? OtpScreenViewController
            else {
                return
            }
            self.navigationController?.pushViewController(OTPVC, animated: true)
        } else {
            errorMessage.isHidden = false
            usernameTextField.text = ""
            passwordTextField.text = ""
        }
    }
    

}

