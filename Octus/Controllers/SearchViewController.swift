//
//  SearchViewController.swift
//  Octus
//
//  Created by Руслан on 02.12.2023.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tovarsCollection: UICollectionView!
    @IBOutlet weak var bag: BagImage!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var search: UITextField!
    @IBOutlet weak var searchView: BlackContour!
    
    private var tovars = [Tovar]()
    private var prepareTovar = Tovar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tovarsCollection.dataSource = self
        tovarsCollection.delegate = self
        search.delegate = self
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bag.fill()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc func keyboardWillAppear() {
        searchView.color = UIColor.black
        searchImage.isHidden = true
    }

    @objc func keyboardWillDisappear() {
        searchView.color = UIColor(named: "gray2")!
        searchImage.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        search.resignFirstResponder()
    }
    
}
extension SearchViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tovars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tovar", for: indexPath) as! TovarHomeCollectionViewCell
        cell.im.sd_setImage(with: URL(string: tovars[indexPath.row].image![0])!)
        cell.brand.text = tovars[indexPath.row].brand?.name
        cell.name.text = tovars[indexPath.row].name
        cell.price.text = "\(tovars[indexPath.row].price!)₽"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        prepareTovar = tovars[indexPath.row]
        performSegue(withIdentifier: "tovar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "tovar" {
            let vc = segue.destination as! TovarViewController
            vc.tovar = prepareTovar
        }
        
    }
    
}
extension SearchViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        Tovar.searchTovar(searchText: textField.text!) { tovars in
            self.tovars = tovars
            self.tovarsCollection.reloadData()
        }
//        Tovar.searchTovar(searchText: textField.text!, field: "brand") { tovars in
//            self.tovars += tovars
//            self.tovarsCollection.reloadData()
//        }
    }
    
}
