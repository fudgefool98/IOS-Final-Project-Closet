//
//  ViewController.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 10/29/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let shirtsArray = [Item]()
    let pantsArray = [Item]()
    let shoesArray = [Item]()
    var outfitsArray = [Outfit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    enum category {
        case shoes
        case pants
        case shirt
    }
    
    func createItem () {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let formalTagText = segment.selectedSegmentIndex
        let weatherTagText = segment.selectedSegmentIndex
        let categoryText = segment.selectedSegmentIndex
        
        let pngImageData = UIImagePNGRepresentation(imageView.image)
        let result = write(toFile: pngImageData!)
        
        let newItem = Item(category: categoryText, formalTag: formalTagText, photo: result, weatherTag: weatherTagText)
        
        do {
            try managedContext.save()
            
            switch categoryText {
                case "Shirt":
                    return shirtsArray.insert(newItem, at: 0)
                case "Shoes":
                    return shoesArray.insert(newItem, at: 0)
                case "Pants":
                    return pantsArray.insert(newItem, at: 0)
            }
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    
    }
    
    func updateItem (updateItem: Item) -> Item {
        
        let formalTagText = segment.selectedSegmentIndex
        let weatherTagText = segment.selectedSegmentIndex
        let categoryText = segment.selectedSegmentIndex
        
        let pngImageData = UIImagePNGRepresentation(imageView.image)
        let result = write(toFile: pngImageData!)
        
        updateItem = Item(category: categoryText, formalTag: formalTagText, photo: result, weatherTag: weatherTagText)
        
        return updateItem
        
    }
    
    func deleteItem (deleteItem: Item) {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        managedContext.delete(deleteItem)
    }
    
    func createOutfit (shoeItem: Item, shirtItem: Item, pantItem: Item) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if (shoeItem.category == nil || shirtItem.category == nil || pantItem.category == nil) {
            print("Can't create outfit. Item is empty")
            return
        }
        
        let newOutfit = Outfit(shoes: shoeItem, shirt: shirtItem, pants: pantItem)
        
        do {
            try managedContext.save()
            
            outfitsArray.insert(newOutfit!, at: 0)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
    }
    
    func deleteOutfit (deleteOutfit: Outfit) {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        managedContext.delete(deleteOutfit)
    }

    func printItem (printItem: Item) {
        segment.selectedSegmentIndex = Int(printItem.formalTag)
        segmented.selectedSegmentIndex = Int(printItem.weatherTag)
        segment.selectedSegmentIndex = Int(printItem.category)
        
        UIImage.image = printItem.photo
    }

}

