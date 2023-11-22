//
//  BodyTypeViewController.swift
//  Octus
//
//  Created by Руслан on 19.03.2024.
//

import UIKit

class BodyTypeViewController: UIViewController {
    
    @IBOutlet weak var first: UIView!
    @IBOutlet weak var four: UIView!
    @IBOutlet weak var third: UIView!
    @IBOutlet weak var second: UIView!
    var bodyTypeSelect:String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func next(_ sender: UIButton) {
        guard bodyTypeSelect != nil else {return}
        performSegue(withIdentifier: "nextFirst", sender: self)
    }
    
    @IBAction func selectBody(_ sender: UIButton) {
        BlackContour().deleteBorder(view: first)
        BlackContour().deleteBorder(view: second)
        BlackContour().deleteBorder(view: third)
        BlackContour().deleteBorder(view: four)
        switch sender.tag {
        case 1:
            BlackContour().createBorder(view: first)
            bodyTypeSelect = "Pear"
        case 2:
            BlackContour().createBorder(view: second)
            bodyTypeSelect = "Strawberry"
        case 3:
            BlackContour().createBorder(view: third)
            bodyTypeSelect = "Column"
        case 4:
            BlackContour().createBorder(view: four)
            bodyTypeSelect = "Hourglass"
        default:
            break
        }
    }
    

}
