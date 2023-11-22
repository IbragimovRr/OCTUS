//
//  LogoViewController.swift
//  Octus
//
//  Created by Руслан on 22.11.2023.
//

import UIKit

class LogoViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        if UD().getCurrentUser() == true {
            performSegue(withIdentifier: "currentTrue", sender: self)
        }
    }
    
    @IBAction func site(_ sender: UIButton) {
        guard let urlSite = URL(string: "octus.world") else {return}
        UIApplication.shared.open(urlSite)
    }
    
    
}
