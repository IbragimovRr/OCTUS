//
//  GenderViewController.swift
//  Octus
//
//  Created by Руслан on 22.11.2023.
//

import UIKit

class GenderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func female(_ sender: Any) {
        UD().saveGender(gender: Gender.female)
        performSegue(withIdentifier: "info", sender: self)
    }
    
    @IBAction func male(_ sender: Any) {
        UD().saveGender(gender: Gender.male)
        performSegue(withIdentifier: "info", sender: self)
    }
    
}
