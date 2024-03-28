//
//  SignInEmailAndPasswordViewController.swift
//  Octus
//
//  Created by Руслан on 10.12.2023.
//

import UIKit
import FirebaseAuth

class SignInEmailAndPasswordViewController: UIViewController {
    
    @IBOutlet weak var eye: UIButton!
    @IBOutlet weak var registrBottom: NSLayoutConstraint!
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var passwordView: BlackContour!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var emailView: BlackContour!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorView: BlackContour!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.becomeFirstResponder()
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
    
    
    @IBAction func signIn(_ sender: UIButton) {
        Registration().signInEmailAndPassword(email: email.text ?? "", password: password.text ?? "") { credential, error in
            if error == nil {
                UD().saveUserID(id: self.email.text ?? "")
                Registration().getNameUserInFirestore(nameDocument: self.email.text ?? "")
                self.performSegue(withIdentifier: "succes", sender: self)
            }else {
                self.errorView.isHidden = false
                self.errorText.text = AuthErrorCode.Code(rawValue: error!._code)!.errorMessage
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.errorView.isHidden = true
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
