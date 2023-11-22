//
//  TovarViewController.swift
//  Octus
//
//  Created by Руслан on 28.11.2023.
//

import UIKit

class TovarViewController: UIViewController {
    
    @IBOutlet weak var succes: UIView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var constantIfHiddenColor: NSLayoutConstraint!
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var colorLbl: UILabel!
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var colorCollection: UICollectionView!
    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var sizeHiden: BlackContour!
    @IBOutlet weak var favorit: UIButton!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    var tovar = Tovar()
    private var sizeEmpty = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTovar()
        height()
        empty()
        colorCollection.delegate = self
        colorCollection.dataSource = self
        imageCollection.delegate = self
        imageCollection.dataSource = self
        picker.delegate = self
        picker.dataSource = self
    }
    
    private func getTovar() {
        guard let article = tovar.article else { self.navigationController?.popViewController(animated: true)
            return
        }
        print(article)
        Tovar.getTovarByArticle(article: article) { tovarRes in
            self.tovar = tovarRes
            self.fillTovar()
            self.imageCollection.reloadData()
            self.colorCollection.reloadData()
            self.picker.reloadAllComponents()
        }
    }
    
    private func fillTovar(){
        brandLbl.text = tovar.brand?.name
        nameLbl.text = tovar.name
        priceLbl.text = "\(tovar.price!)₽"
        
    }
    
    private func empty() {
        if tovar.color?.isEmpty == false {
            colorLbl.isHidden = false
            colorCollection.isHidden = false
            constantIfHiddenColor.constant = 30
        }else{
            constantIfHiddenColor.constant = -20 - colorCollection.bounds.height - colorLbl.bounds.height
            colorLbl.isHidden = true
            colorCollection.isHidden = true
        }
        
        if tovar.size?.isEmpty == true {
            sizeLbl.text = "Нет размеров"
            sizeEmpty = true
        }
    }
    
    private func height() {
        let screenHeight = UIScreen.main.bounds.height
        imageHeight.constant = screenHeight - 250
    }
    
    private func openSizeDesign(){
        guard sizeEmpty == false else { return }
        sizeHiden.isHidden = false
        sizeLbl.text = tovar.size![0]
    }
    
    private func closeSizeDesign() {
        sizeHiden.isHidden = true
    }
    
    
    @IBAction func favoritBtn(_ sender: UIButton) {
//        if Favorite().checkSelection(tovar: Tovar)
        if sender.tag == 0{
            sender.setImage(UIImage(named: "activeHeart"), for: .normal)
            sender.tag = 1
        }else{
            sender.setImage(UIImage(named: "staticHeart"), for: .normal)
            sender.tag = 0
        }
    }
    
    
    @IBAction func addBasket(_ sender: UIButton) {
        if sender.tag == 1 {
            closeSizeDesign()
        }
        if sizeLbl.text == "Выберите размер" || sizeEmpty == true {
            openSizeDesign()
        }else{
            succes.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.succes.isHidden = true
            }
            Bag().saveToBag(tovar: tovar, size: sizeLbl.text)
        }
    }
    
    @IBAction func openSize(_ sender: UIButton) {
        openSizeDesign()
    }
    
    @IBAction func backSizeHidden(_ sender: UIButton) {
        closeSizeDesign()
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension TovarViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollection {
            guard tovar.image?.isEmpty == false else {return 0}
            return tovar.image!.count
        }else {
            guard tovar.color?.isEmpty == false else {return 0}
            return tovar.color!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == imageCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TovarImage", for: indexPath) as! TovarImageCollectionViewCell
            cell.im.sd_setImage(with: URL(string: tovar.image![indexPath.row])!)
            return cell
            
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TovarColor", for: indexPath) as! TovarColorCollectionViewCell
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageCollection.bounds.width, height: imageCollection.bounds.height)
    }
    
    
    
    
}


extension TovarViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let sizes = tovar.size else { return 0}
        return sizes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tovar.size![row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sizeLbl.text = tovar.size![row]
    }
    
}
