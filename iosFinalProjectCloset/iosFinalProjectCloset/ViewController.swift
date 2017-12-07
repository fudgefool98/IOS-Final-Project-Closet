//
//  ViewController.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 10/29/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

//    var shirtsArray = [Item]()
//    var pantsArray = [Item]()
//    var shoesArray = [Item]()
//    var outfitsArray = [Outfit]()
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
//
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//
//    enum category {
//        case shoes
//        case pants
//        case shirt
//    }
//
//    func createItem () {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        let formalTagText = formalSegment.selectedSegmentIndex
//        let weatherTagText = weatherSegment.selectedSegmentIndex
//        let categoryText = catergorySegment.selectedSegmentIndex
//
//        let pngImageData = UIImagePNGRepresentation(imageView.image)
//        let result = write(toFile: pngImageData!)
//
//        let newItem = Item(category: categoryText, formalTag: formalTagText, photo: result, weatherTag: weatherTagText)
//
//        do {
//            try managedContext.save()
//
//            switch categoryText {
//                case 0:
//                    return shirtsArray.insert(newItem, at: 0)
//                case 1:
//                    return shoesArray.insert(newItem, at: 0)
//                case 2:
//                    return pantsArray.insert(newItem, at: 0)
//            }
//
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//
//    }
//
//    func updateItem (updateItem: Item) -> Item {
//
//        let formalTagText = formalSegment.selectedSegmentIndex
//        let weatherTagText = weatherSegment.selectedSegmentIndex
//        let categoryText = categorySegment.selectedSegmentIndex
//
//        let pngImageData = UIImagePNGRepresentation(imageView.image)
//        let result = write(toFile: pngImageData!)
//
//        updateItem = Item(category: categoryText, formalTag: formalTagText, photo: result, weatherTag: weatherTagText)
//
//        return updateItem
//
//    }
//
//    func deleteItem (deleteItem: Item) {
//        switch deleteItem.category {
//        case 0:
//            return shirtsArray = shirtsArray.filter() { $0 != deleteItem }
//        case 1:
//            return shoesArray = shoesArray.filter() { $0 != deleteItem }
//        case 2:
//            return pantsArray = pantsArray.filter() { $0 != deleteItem }
//        default:
//            print ("Error deleting Item from array")
//            return
//        }
//        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        managedContext.delete(deleteItem)
//    }
//
//    func createOutfit (shoeItem: Item, shirtItem: Item, pantItem: Item) {
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        let newOutfit = Outfit(shoes: shoeItem, shirt: shirtItem, pants: pantItem)
//
//        do {
//            try managedContext.save()
//
//            outfitsArray.insert(newOutfit!, at: 0)
//
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//
//
//    }
//
//    func deleteOutfit (deleteOutfit: Outfit) {
//
//        outfitsArray = outfitsArray.filter() { $0 != deleteOutfit }
//
//        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        managedContext.delete(deleteOutfit)
//    }
//
//    func printItem (printItem: Item) {
//        formalSegment.selectedSegmentIndex = Int(printItem.formalTag)
//        weatherSegmented.selectedSegmentIndex = Int(printItem.weatherTag)
//        catergorySegment.selectedSegmentIndex = Int(printItem.category)
//
//        UIImage.image = printItem.photo
//    }

}

