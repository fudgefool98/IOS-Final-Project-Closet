//
//  ShoesCollectionViewCell.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 12/1/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit

class ShoesCollectionViewCell: UICollectionViewCell {
    var toggleCellSelection = true
    var image: Image! {
        
        didSet {
            updateUI()
        }
    }

    override var isSelected: Bool {
        didSet {
            
            if (toggleCellSelection == true) {
                toggleCellSelection = false
                shoesImage.alpha = 0.75
                shoesImage?.layer.borderWidth = 2
                shoesImage?.layer.borderColor = UIColor.black.cgColor
            } else {
                toggleCellSelection = true
                shoesImage.alpha = 1.0
                shoesImage?.layer.borderWidth = 0
                shoesImage?.layer.borderColor = UIColor.white.cgColor
            }
        }
    }
            
    @IBOutlet weak var shoesImage: UIImageView!
    
    func updateUI() {
        shoesImage.image = image.image
        
    }
}
