//
//  PantsCollectionViewCell.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 12/1/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit

class PantsCollectionViewCell: UICollectionViewCell {
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
                pantsImage.alpha = 0.75
                pantsImage?.layer.borderWidth = 2
                pantsImage?.layer.borderColor = UIColor.black.cgColor
            } else {
                toggleCellSelection = true
                pantsImage.alpha = 1.0
                pantsImage?.layer.borderWidth = 0
                pantsImage?.layer.borderColor = UIColor.white.cgColor
            }
        }
    }
            
    @IBOutlet weak var pantsImage: UIImageView!
    
    func updateUI() {
        pantsImage.image = image.image
    }
}
