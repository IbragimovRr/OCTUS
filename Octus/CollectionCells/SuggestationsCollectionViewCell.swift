//
//  SuggestationsCollectionViewCell.swift
//  Octus
//
//  Created by Руслан on 27.03.2024.
//

import UIKit

class SuggestationsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var im: UIImageView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        secondCollectionView.delegate = self
        secondCollectionView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
