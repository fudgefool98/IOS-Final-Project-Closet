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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<Outfit> = Outfit.fetchRequest()
        
        do {
            if let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                outfits = (try managedContext.fetch(fetchRequest)) ?? []
                //items = (try managedContext.fetch(fetchRequest)) ?? []
            }
            
        } catch {
            print(error)
            return
        }
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //chosenOutfit = outfits[indexPath.row]
        
       

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

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let identifier = segue.identifier else {return }
//
//        switch identifier {
//        case "showOutfit":
//            if let navController = segue.destination as? UINavigationController, let destination = navController.viewControllers.first as? CreateOutfitViewController {
//                if let shirt = chosenOutfit.shirt?.photo, let pants = chosenOutfit.pants?.photo, let shoes = chosenOutfit.shoes?.photo {
//                    destination.shirtCollectionView = shirt
//                    destination.pantsCollectionView = pants
//                    destination.shoesCollectionView = shoes
//                }
//            }
//        default:
//            break
//        }
//    }
    


}
