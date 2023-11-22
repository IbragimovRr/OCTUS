//
//  HeightViewController.swift
//  Octus
//
//  Created by Руслан on 19.03.2024.
//

import UIKit

class HeightViewController: UIViewController {

    @IBOutlet var height:UITextField!
    @IBOutlet weak var nextBottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpObserver()
    }
    
    private func setUpObserver() {
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShow),name: UIResponder.keyboardWillShowNotification,object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            nextBottom.constant = keyboardHeight
        }
    }
    
    @IBAction func next(_ sender:UIButton) {
        if height.text != "" {
            performSegue(withIdentifier: "next", sender: self)
        }
    }

    @IBAction func tap(_ sender: Any) {
       // height.resignFirstResponder()
    }
    
}
