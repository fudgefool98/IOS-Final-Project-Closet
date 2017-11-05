//
//  ViewController.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 10/29/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        
        let formalTagText = segment.titleForSegmentAtIndex(segment.selectedSegmentIndex)
        let weatherTagText = segment.titleForSegmentAtIndex(segment.selectedSegmentIndex)
        let categoryText = segment.titleForSegmentAtIndex(segment.selectedSegmentIndex)
        
        let pngImageData = UIImagePNGRepresentation(imageView)
        let result = write(toFile: pngImageData!)
        
        let newItem = Item(category: categoryText, formalTag: formalTagText, photo: result, weatherTag: weatherTagText)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    
    }
    
    func updateItem (updateItem: Item) -> Item {
        
        let formalTagText = segment.titleForSegmentAtIndex(segment.selectedSegmentIndex)
        let weatherTagText = segment.titleForSegmentAtIndex(segment.selectedSegmentIndex)
        let categoryText = segment.titleForSegmentAtIndex(segment.selectedSegmentIndex)
        
        let pngImageData = UIImagePNGRepresentation(imageView)
        let result = write(toFile: pngImageData!)
        
        updateItem = Item(category: categoryText, formalTag: formalTagText, photo: result, weatherTag: weatherTagText)
        
        return updateItem
        
    }
    
    func deleteItem (deleteItem: Item) {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        managedContext.delete(deleteItem)
    }

    

}

