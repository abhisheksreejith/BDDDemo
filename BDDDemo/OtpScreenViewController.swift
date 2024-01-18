//
//  OtpScreenViewController.swift
//  Milestone 4
//
//  Created by Abhishek-Sreejith on 26/09/23.
//
import UIKit
import OTPFieldView
class OtpScreenViewController: UIViewController {
    @IBOutlet weak var invalidOtpView: UILabel!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var resendTextView: UITextView!
    @IBOutlet weak var otpTextFieldText: UITextField!
    var timer = Timer()
    var countdown = 30
    var enteredOTP = ""
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
        if otpTextFieldText.text == "12345"{
            invalidOtpView.isHidden = true
            let alert = UIAlertController(title: "User Logged In", message: "The user was logged in.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            invalidOtpView.isHidden = false
            otpTextFieldText.text = ""
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
