//
//  SignUpEmailViewController.swift
//  Octus
//
//  Created by Руслан on 08.12.2023.
//

import UIKit
import FirebaseAuth

class SignUpEmailViewController: UIViewController {
    
    @IBOutlet weak var eye: UIButton!
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var errorViewHidden: BlackContour!
    @IBOutlet weak var registrBottom: NSLayoutConstraint!
    @IBOutlet weak var nameView: BlackContour!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var passwordView: BlackContour!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailView: BlackContour!
    @IBOutlet weak var email: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.becomeFirstResponder()
        password.isSecureTextEntry = true
        setUpObserver()
    }
    
    private func setUpObserver() {
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShow),name: UIResponder.keyboardWillShowNotification,object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            registrBottom.constant = keyboardHeight
        }
    }
    
    @IBAction func registr(_ sender: UIButton) {
        guard name.text!.count >= 2 else { nameView.color = UIColor.red; return }
        Registration().createEmailAndPassword(email: email.text ?? "", password: password.text ?? "") { credential, error in
            if error == nil {
                self.performSegue(withIdentifier: "sucess", sender: self)
            }else {
                self.errorViewHidden.isHidden = false
                self.errorText.text = AuthErrorCode.Code(rawValue: error!._code)!.errorMessage
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.errorViewHidden.isHidden = true
                }
            }
        }
    }
    
    @IBAction func passwordOpenOrClose(_ sender: UIButton) {
        if password.isSecureTextEntry {
            password.isSecureTextEntry = false
            eye.setImage(UIImage(named: "openEye"), for: .normal)
        }else{
            password.isSecureTextEntry = true
            eye.setImage(UIImage(named: "closeEye"), for: .normal)
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
