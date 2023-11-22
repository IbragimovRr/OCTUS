//
//  HomeViewController.swift
//  Octus
//
//  Created by Руслан on 01.12.2023.
//

import UIKit
import FirebaseFirestore
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var bag: BagImage!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var typeClothesCollection:UICollectionView!
    @IBOutlet weak var tovarCollectionView: UICollectionView!
    
    private var typeClothesArray = ["Новинки","Бренды","Одежда","Обувь","Сумки","Акссесуары"]
    private var tovarArray = [Tovar]()
    private var selectType = 0
    private var tovar = Tovar()
    private var brand = Brand()
    private var prepareTovar = Tovar()

    override func viewDidLoad() {
        super.viewDidLoad()
        typeClothesCollection.delegate = self
        typeClothesCollection.dataSource = self
        tovarCollectionView.dataSource = self
        tovarCollectionView.delegate = self
        scrollView.delegate = self
        addTovar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bag.fill()
    }
    

    func addTovar(){
        tovarArray.removeAll()
        Tovar.getTovars(type: stringToTypeClothes()) { tovars in
            self.tovarArray = tovars
            self.tovarCollectionView.reloadData()
        }
    }
    
    func stringToTypeClothes() -> TypeClothes{
        switch selectType {
        case 0:
            return .news
        case 1:
            return .brand
        case 2:
            return .clothes
        case 3:
            return .shoes
        case 4:
            return .bag
        case 5:
            return .accessories
        default:
            return .clothes
        }
    }
    
    
    @IBAction func search(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
    
    
}
extension HomeViewController:UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == typeClothesCollection{
            return typeClothesArray.count
        }else{
            return tovarArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == typeClothesCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeClothes", for: indexPath) as! TypeClothesCollectionViewCell
            if selectType == indexPath.row {
                cell.viewSelect.layer.borderColor = UIColor.black.cgColor
                cell.viewSelect.layer.borderWidth = 1
            }else {
                cell.viewSelect.layer.borderColor = UIColor.clear.cgColor
            }
            cell.viewSelect.layer.cornerRadius = 3
            cell.name.text = typeClothesArray[indexPath.row]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tovar", for: indexPath) as! TovarHomeCollectionViewCell
            
            cell.im.sd_setImage(with: URL(string: tovarArray[indexPath.row].image![0])!)
            cell.brand.text = tovarArray[indexPath.row].brand?.name
            cell.name.text = tovarArray[indexPath.row].name
            cell.price.text = "\(tovarArray[indexPath.row].price!)₽"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == typeClothesCollection{
            selectType = indexPath.row
            addTovar()
            typeClothesCollection.reloadData()
        }else{
            prepareTovar = tovarArray[indexPath.row]
            performSegue(withIdentifier: "tovar", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "tovar" {
            let vc = segue.destination as! TovarViewController
            vc.tovar = prepareTovar
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tovarCollectionView {
            let widthScreen = UIScreen.main.bounds.width
            let result = (widthScreen / 2) - 30
            return CGSize(width: result, height: 240)
        }else {
            return .zero
        }
    }
    
    
    
}

extension HomeViewController :UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tovarCollectionView.contentOffset.y <= 250 {
            self.scrollView.contentOffset = tovarCollectionView.contentOffset
        }else {
            self.scrollView.setContentOffset(CGPoint(x: 0, y: 250), animated: false)
        }
    }
}
