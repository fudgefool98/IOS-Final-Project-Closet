//
//  PantsCollectionViewCell.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 12/1/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit

class PantsCollectionViewCell: UICollectionViewCell {
    var image: Image! {
        didSet {
            updateUI()
        }
    }
    @IBOutlet weak var pantsImage: UIImageView!
    
    func updateUI() {
        pantsImage.image = image.image
    }
}
