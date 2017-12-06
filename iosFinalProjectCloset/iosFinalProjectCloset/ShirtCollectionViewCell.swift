//
//  ShirtCollectionViewCell.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 11/30/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit

class ShirtCollectionViewCell: UICollectionViewCell {
    
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
                    shirtImage.alpha = 0.75
                    shirtImage?.layer.borderWidth = 2
                    shirtImage?.layer.borderColor = UIColor.black.cgColor
                } else {
                    shirtImage.alpha = 1.0
                    shirtImage?.layer.borderWidth = 0
                    shirtImage?.layer.borderColor = UIColor.white.cgColor
                }
            }
        }
    }

    
    @IBOutlet weak var shirtImage: UIImageView!
    
    func updateUI() {
        shirtImage.image = image.image
    }
}
