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

    override var isSelected: Bool {
        get {
            return super.isSelected;
        }
        
        set {
            if (super.isSelected != newValue) {
                super.isSelected = newValue
                
                
                if (newValue == true) {
                    shoesImage.alpha = 0.75
                    shoesImage?.layer.borderWidth = 2
                    shoesImage?.layer.borderColor = UIColor.black.cgColor
                } else {
                    shoesImage.alpha = 1.0
                    shoesImage?.layer.borderWidth = 0
                    shoesImage?.layer.borderColor = UIColor.white.cgColor
                }
            }
        }
    }
            
    @IBOutlet weak var shoesImage: UIImageView!
    
    func updateUI() {
        shoesImage.image = image.image
        
    }
}
