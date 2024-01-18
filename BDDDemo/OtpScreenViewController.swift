//
//  OtpScreenViewController.swift
//  Milestone 4
//
//  Created by Abhishek-Sreejith on 26/09/23.
//
import UIKit
import OTPFieldView
import Amplify

class OtpScreenViewController: UIViewController {
    @IBOutlet weak var invalidOtpView: UILabel!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var resendTextView: UITextView!
    @IBOutlet weak var otpTextFieldText: UITextField!
    var timer = Timer()
    var countdown = 30
    var enteredOTP = ""
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem?.tintColor = .white
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        //verifyButton.isEnabled = false
        verifyButton.alpha = 0.75
        verifyButton.layer.cornerRadius = 12
        resendTextView.delegate = self
        resendTextView.isEditable = false
        resendTextView.isScrollEnabled = false
        resendTextView.textContainer.lineFragmentPadding = 0.0
        resendTextView.textContainerInset = .zero

    }
    @objc func updateTimer() {
        countdown -= 1
        var text = NSLocalizedString("Resend", comment: "Recent Text")
        if countdown == 0 {
            let linktext = NSLocalizedString("ResendLink", comment: "Recent Link")
            let linkRange = (text as NSString).range(of: linktext)
            let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.label]
            let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
            let linkTextAttributes: [NSAttributedString.Key: Any] = [ .link: "www.google.com"]
            attributedString.addAttributes(linkTextAttributes, range: linkRange)
            resendTextView.attributedText = attributedString
            timer.invalidate()
        } else {
            text += " \(countdown)s"
            let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.label]
            let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
            resendTextView.attributedText = attributedString
        }
    }
    @IBAction func verifyButtonPressed(_ sender: Any) {
        guard let verificationCode = otpTextFieldText.text else {return}
        self.view.showLoader()
        Task {
            do {
                try await confirmEmail(forUsername: username, with: verificationCode)
        
            } catch {
                print("Error signing out:", error)
            }
        }
    }
    func confirmEmail(forUsername username: String, with verificationCode: String) async throws{
        do {
            _ = try await Amplify.Auth.confirmSignUp(for: username, confirmationCode: verificationCode)
            invalidOtpView.isHidden = true
            let alert = UIAlertController(title: "Sign up Successfull", message: "Login using the credentials.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                guard let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
            alert.addAction(okAction)
            present(alert, animated: true)
            print("Email confirmed successfully")
            
        } catch {
            invalidOtpView.isHidden = false
            otpTextFieldText.text = ""
            print("Error confirming email:", error)
        }
    }


}
// MARK: - TextView delegate
extension OtpScreenViewController: UITextViewDelegate {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    func textView(_ textView: UITextView, shouldInteractWith URL: URL,
                  in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        timer.invalidate()
        countdown = 30
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        return false
    }
}
