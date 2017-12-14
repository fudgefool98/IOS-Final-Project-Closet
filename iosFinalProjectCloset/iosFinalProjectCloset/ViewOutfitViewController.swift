//
//  ViewOutfitViewController.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 11/30/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class ViewOutfitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var outfitTable: UITableView!
    var outfits:[Outfit] = []
    var images:[UIImage] = []
    var items:[Item] = []
    var shirtIndex: IndexPath?
    var pantsIndex: IndexPath?
    var shoesIndex: IndexPath?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outfits = createOutfits()
        items = createItems()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(outfits.count)
        return outfits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        images.append((outfits[indexPath.row].shirt?.photo)!)
        images.append((outfits[indexPath.row].pants?.photo)!)
        images.append((outfits[indexPath.row].shoes?.photo)!)
        
        cell.imageView?.image = stitchImages(images: images, isVertical: false)
        
        images = []
        return cell
    }
    
    func stitchImages(images: [UIImage], isVertical: Bool) -> UIImage {
        var stitchedImages : UIImage!
        if images.count > 0 {
            var maxWidth = CGFloat(0), maxHeight = CGFloat(0)
            for image in images {
                if image.size.width > maxWidth {
                    maxWidth = image.size.width
                }
                if image.size.height > maxHeight {
                    maxHeight = image.size.height
                }
            }
            var totalSize : CGSize
            let maxSize = CGSize(width: maxWidth, height: maxHeight)
            if isVertical {
                totalSize = CGSize(width: maxSize.width, height: maxSize.height * (CGFloat)(images.count))
            } else {
                totalSize = CGSize(width: maxSize.width  * (CGFloat)(images.count), height:  maxSize.height)
            }
            UIGraphicsBeginImageContext(totalSize)
            for image in images {
                let offset = (CGFloat)(images.index(of: image)!)
                let rect =  AVMakeRect(aspectRatio: image.size, insideRect: isVertical ?
                    CGRect(x: 0, y: maxSize.height * offset, width: maxSize.width, height: maxSize.height) :
                    CGRect(x: maxSize.width * offset, y: 0, width: maxSize.width, height: maxSize.height))
                image.draw(in: rect)
            }
            stitchedImages = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return stitchedImages
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            if let destination = segue.destination as? CreateOutfitViewController, let selectedRow = outfitTable.indexPathForSelectedRow?.row {

                let chosenOutfit = outfits[selectedRow]
                
                let shirtItems = items.filter({ $0.category == 0 })
                let pantsItems = items.filter({ $0.category == 1 })
                let shoesItems = items.filter({ $0.category == 2 })
                
                shirtIndex = checkIndexItem(items: shirtItems, outfit: chosenOutfit, category: 0)
                pantsIndex = checkIndexItem(items: pantsItems, outfit: chosenOutfit, category: 1)
                shoesIndex = checkIndexItem(items: shoesItems, outfit: chosenOutfit, category: 2)

                
                if let shirtIndex = shirtIndex,
                    let pantsIndex = pantsIndex,
                    let shoesIndex = shoesIndex {
    
                        destination.viewShirt = true
                        destination.viewPants = true
                        destination.viewShoes = true
                        destination.selectedShirtIndexPath = shirtIndex
                        destination.selectedPantsIndexPath = pantsIndex
                        destination.selectedShoesIndexPath = shoesIndex
                    
                     
                }
            }
    
    }


}
