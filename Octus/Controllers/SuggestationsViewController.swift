//
//  SuggestationsViewController.swift
//  Octus
//
//  Created by Руслан on 27.03.2024.
//

import UIKit

class SuggestationsViewController: UIViewController {
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.delegate = self
        collectionview.dataSource = self
        
    }
    


}
extension SuggestationsViewController :UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstSug", for: indexPath) as! SuggestationsCollectionViewCell
        return cell
    }
    
    
    
    
}
extension SuggestationsCollectionViewCell: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondSug", for: indexPath) 
        return cell
    }
    
    
}
