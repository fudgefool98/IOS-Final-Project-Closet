//
//  ShoesCollectionViewCell.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 12/1/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit

class ShoesCollectionViewCell: UICollectionViewCell {
    var image: Image! {
        didSet {
            updateUI()
        }
    }
    @IBOutlet weak var shoesImage: UIImageView!
    
    func updateUI() {
        shoesImage.image = image.image
    }
}
