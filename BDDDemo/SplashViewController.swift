//
//  SplashViewController.swift
//  BDDDemo
//
//  Created by Abhishek C Sreejith on 27/02/24.
//

import UIKit
import Amplify

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task{
            await checkUserAuthentication()
        }
        
    }
    
    func checkUserAuthentication() async {
        do {
            let authSession = try await Amplify.Auth.fetchAuthSession()
            if authSession.isSignedIn {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                guard let homescreenVC = storyBoard.instantiateViewController(withIdentifier: "HomeScreenViewController") as? HomeScreenViewController
                else { return }
                self.navigationController?.pushViewController(homescreenVC, animated: true)
            } else {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                guard let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
        } catch {
            print("Error fetching auth session:", error)
        }
    }
    
}
