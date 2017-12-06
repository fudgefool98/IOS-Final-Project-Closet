//
//  Image.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 11/30/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit
import CoreData

class Image {
    var image: UIImage!
    
    init(image: UIImage!) {
        self.image = image
    }
    
    
    
    static func createImages() -> [Image] {
        return [Image(image: UIImage(named:"images-1")), Image(image: UIImage(named:"images-2")), Image(image: UIImage(named:"images-3")), Image(image: UIImage(named:"images-4")), Image(image: UIImage(named:"images-5")), Image(image: UIImage(named:"images-6")), Image(image: UIImage(named:"images-7")), Image(image: UIImage(named:"images-8")), Image(image: UIImage(named: "images-9")), Image(image: UIImage(named: "images-10")), Image(image: UIImage(named: "images-9")), Image(image: UIImage(named: "images-10")), Image(image: UIImage(named: "images-11")), Image(image: UIImage(named: "images-12"))]
    }
    
    static func createItems(data: Int64) -> [Item] {
        let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "category == %@" , "\(String(describing: data))")
        
        let result = try? managedContext?.fetch(fetchRequest)
        let items = result as! [Item]
        return items
        
    }
}

