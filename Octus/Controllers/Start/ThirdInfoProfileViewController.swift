//
//  ThirdInfoProfileViewController.swift
//  Octus
//
//  Created by Руслан on 22.03.2024.
//

import UIKit

class ThirdInfoProfileViewController: UIViewController {
    
    @IBOutlet weak var firstLbl: UILabel!
    @IBOutlet weak var fivethLbl: UILabel!
    @IBOutlet weak var fourthLbl: UILabel!
    @IBOutlet weak var thirdLbl: UILabel!
    @IBOutlet weak var secondLbl: UILabel!
    @IBOutlet weak var fiveProgress: UIView!
    @IBOutlet weak var fourProgress: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var second: ShadowView!
    @IBOutlet weak var first: ShadowView!
    @IBOutlet weak var third: ShadowView!
    @IBOutlet weak var fiveth: ShadowView!
    @IBOutlet weak var fourth: ShadowView!
    
    
    var progresInt: Int = 3{
        didSet {
            updateProgres()
        }
    }
    var selectInt:Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func selectBtn(_ sender: UIButton) {
        deleteAllBorder()
        createBorderByTap(sender: sender)
        selectInt = sender.tag
    }
    
    @IBAction func nextBtn(_ sender: UIButton) {
        guard selectInt != nil else { return }
        progresInt += 1
        deleteAllBorder()
    }
    
    func fourProgresDesign() {
        third.isHidden = false
        fourth.isHidden = false
        fiveth.isHidden = false
        titleLbl.text = "What's your age range?"
        firstLbl.text = "18-24"
        secondLbl.text = "25-34"
        thirdLbl.text = "35-44"
        fourthLbl.text = "45-64"
        fivethLbl.text = "65+"
    }
    
    func fiveProgresDesign() {
        third.isHidden = false
        fourth.isHidden = false
        fiveth.isHidden = true
        titleLbl.text = "Which brands do you want to see recommendations from?"
        firstLbl.text = "Fast fashion"
        secondLbl.text = "Premium brands"
        thirdLbl.text = "Luxury labels"
        fourthLbl.text = "A mix of fast fashion and designer brands"
    }
    
    
    func deleteAllBorder() {
        BlackContour().deleteBorder(view: first)
        BlackContour().deleteBorder(view: second)
        BlackContour().deleteBorder(view: third)
        BlackContour().deleteBorder(view: fourth)
        BlackContour().deleteBorder(view: fiveth)
        selectInt = nil
    }
    
    func createBorderByTap(sender:UIButton) {
        switch sender.tag {
        case 1:
            BlackContour().createBorder(view: first)
        case 2:
            BlackContour().createBorder(view: second)
        case 3:
            BlackContour().createBorder(view: third)
        case 4:
            BlackContour().createBorder(view: fourth)
        case 5:
            BlackContour().createBorder(view: fiveth)
        default:
            break
        }
    }

    func updateProgres() {
        if progresInt == 4 {
            fourProgresDesign()
            fourProgress.backgroundColor = UIColor.black
        }else if progresInt == 5 {
            fiveProgresDesign()
            fiveProgress.backgroundColor = UIColor.black
        }else if progresInt == 6 {
            UD().currentUser(current: true)
            performSegue(withIdentifier: "finish", sender: self)
        }else if progresInt > 6 {
            progresInt = 5
        }
    }
}
