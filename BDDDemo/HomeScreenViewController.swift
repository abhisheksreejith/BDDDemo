//
//  HomeScreenViewController.swift
//  BDDDemo
//
//  Created by Abhishek C Sreejith on 27/02/24.
//

import UIKit
import Amplify

class HomeScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        self.view.showLoader()
        Task {
            do {
                try await signOut()
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                guard let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
                self.navigationController?.pushViewController(loginVC, animated: true)
            } catch {
                print("Error signing out:", error)
            }
        }
    }
    func signOut() async throws {
        _ = await Amplify.Auth.signOut()
        
        print("Sign out succeeded")
        
    }
}
