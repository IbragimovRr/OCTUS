//
//  InformationViewController.swift
//  Octus
//
//  Created by Руслан on 24.11.2023.
//

import UIKit

class InformationViewController: UIViewController {
    
    
    @IBOutlet weak var landingLbl: UILabel!
    @IBOutlet weak var bodyTypeLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pickerHid: UIView!
    @IBOutlet weak var picker: UIPickerView!
    
    private var arrayPicker = [String]()
    private var height = "Укажите свой рост"
    private var bodyType = "Укажите своё телосложение"
    private var landing = "Укажите посадку"
    private var whatOpen: InfoUser?
    private var rowPicker:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
    }
    
    private func addHeight(){
        arrayPicker.removeAll()
        for x in 120...250 {
            self.arrayPicker.append("\(x)")
        }
        picker.reloadAllComponents()
        picker.selectRow(0, inComponent: 0, animated: false)
        height = arrayPicker[0]
    }
    
    private func addBodyType(){
        arrayPicker.removeAll()
        arrayPicker.append("Hourglass")
        arrayPicker.append("Triangle")
        arrayPicker.append("Inverted triangle")
        arrayPicker.append("Rectangle")
        picker.reloadAllComponents()
        picker.selectRow(0, inComponent: 0, animated: false)
        bodyType = arrayPicker[0]
    }
    
    private func addLanding(){
        arrayPicker.removeAll()
        arrayPicker.append("Slim")
        arrayPicker.append("Regular")
        arrayPicker.append("Oversize")
        arrayPicker.append("Plus size")
        picker.reloadAllComponents()
        picker.selectRow(0, inComponent: 0, animated: false)
        landing = arrayPicker[0]
    }
    
    
    
    @IBAction func openBtn(_ sender: UIButton) {
        pickerHid.isHidden = false
        switch sender.tag {
        case 0:
            addHeight()
            whatOpen = .height
        case 1:
            addBodyType()
            whatOpen = .bodyType
        case 2:
            addLanding()
            whatOpen = .landing
        default:
            break
        }
    }
    
    @IBAction func pickerBack(_ sender: Any) {
        pickerHid.isHidden = true
        switch whatOpen {
            case .height:
                height = "Укажите свой рост"
                heightLbl.text = height
            case .bodyType:
                bodyType = "Укажите своё телосложение"
                bodyTypeLbl.text = bodyType
            case .landing:
                landing = "Укажите посадку"
                landingLbl.text = landing
            default:
                break
        }
    }
    
    @IBAction func pickerSelect(_ sender: Any) {
        pickerHid.isHidden = true
        heightLbl.text = height
        bodyTypeLbl.text = bodyType
        landingLbl.text = landing
    }
    
    @IBAction func tapClosePicker(_ sender: Any) {
        pickerHid.isHidden = true
        heightLbl.text = height
        bodyTypeLbl.text = bodyType
        landingLbl.text = landing
    }
    
    
    @IBAction func next(_ sender: Any) {
        if heightLbl.text != "Укажите свой рост" && bodyTypeLbl.text != "Укажите своё телосложение" && landingLbl.text != "Укажите посадку" {
            UD().saveInfoUser(height: heightLbl.text!, bodyType: bodyTypeLbl.text!, landing: landingLbl.text!)
            UD().currentUser(current: true)
            performSegue(withIdentifier: "goHome", sender: self)
        }
    }
    
    
}
extension InformationViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayPicker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard whatOpen != nil else {return}
        switch whatOpen {
            case .height:
                height = arrayPicker[row]
            case .bodyType:
                bodyType = arrayPicker[row]
            case .landing:
                landing = arrayPicker[row]
            default:
                break
        }
        rowPicker = row
    }
}
