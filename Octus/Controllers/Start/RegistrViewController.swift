//
//  RegistrViewController.swift
//  Octus
//
//  Created by Руслан on 08.12.2023.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

class RegistrViewController: UIViewController {
    
    @IBOutlet weak var error: BlackContour!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func google(_ sender: UIButton) {
        
        Registration().google(controller: self) { credential, name in
            if credential != nil {
                Auth.auth().signIn(with: credential!)
                if name == nil {
                    self.alertName()
                }else {
                    UD().saveNameUser(name: name!)
                    self.performSegue(withIdentifier: "succes", sender: self)
                }
            }else {
                self.error.isHidden = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.error.isHidden = true
                }
            }
        }
    }
    
    @IBAction func apple(_ sender: UIButton) {
        let controller = Registration().apple()
        controller.delegate = self
        controller.presentationContextProvider = self
    }
    
}
