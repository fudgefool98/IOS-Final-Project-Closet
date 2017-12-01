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
    @IBOutlet weak var shirtImage: UIImageView!
    
    func updateUI() {
        shirtImage.image = image.image
    }
}
