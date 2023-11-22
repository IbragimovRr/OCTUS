//
//  BagViewController.swift
//  Octus
//
//  Created by Руслан on 04.12.2023.
//

import UIKit

class BagViewController: UIViewController {

    @IBOutlet weak var viewBottomBag: UIView!
    @IBOutlet weak var bagTovarCollectionView: UICollectionView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var itogo: UIStackView!
    @IBOutlet weak var tovarCollection: UICollectionView!
    @IBOutlet weak var emptyBtn: BlackContour!
    @IBOutlet weak var emptyText: UIStackView!
    
    private var numberTovarClick = 0
    private var bagTovars = Bag().getBagTovars() {
        didSet {
            getPrice()
            empty()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        empty()
        bagTovarCollectionView.delegate = self
        bagTovarCollectionView.dataSource = self
        getPrice()
    }
    
    func getPrice() {
        var allPrice = 0
        for x in bagTovars {
            allPrice += x.price
        }
        price.text = "\(allPrice)₽"
    }
    
    
    func empty(){
        if Bag().getBagTovars().isEmpty == false {
            viewBottomBag.isHidden = false
            emptyBtn.isHidden = true
            emptyText.isHidden = true
            tovarCollection.isHidden = false
            itogo.isHidden = false
        }else{
            viewBottomBag.isHidden = true
            emptyBtn.isHidden = false
            emptyText.isHidden = false
            tovarCollection.isHidden = true
            itogo.isHidden = true
        }
    }
    
    
    
    @IBAction func exit(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func returnTovar(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension BagViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bagTovars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bagTovar", for: indexPath) as! BagTovarCollectionViewCell
        cell.article.text = "ID \(bagTovars[indexPath.row].article)"
        cell.brand.text = bagTovars[indexPath.row].name
        cell.price.text = "\(bagTovars[indexPath.row].price)₽"
        cell.sizeLbl.text = "Размер \(bagTovars[indexPath.row].size!)"
        cell.im.sd_setImage(with: URL(string: bagTovars[indexPath.row].image!)!)
        cell.deleteBtn.addTarget(self, action: #selector(deleteTovar), for: .touchUpInside)
        cell.deleteBtn.tag = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        numberTovarClick = indexPath.row
        performSegue(withIdentifier: "tovar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var tovar = Tovar()
        tovar.article = bagTovars[numberTovarClick].article
        if segue.identifier == "tovar" {
            let vc = segue.destination as! TovarViewController
            vc.tovar = tovar
        }
        
    }
    
    @objc func deleteTovar(sender:UIButton!) {
        Bag().delete(tovar: bagTovars[sender.tag])
        bagTovars = Bag().getBagTovars()
        tovarCollection.reloadData()
    }
    
    
}
