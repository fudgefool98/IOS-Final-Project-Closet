//
//  Item+CoreDataClass.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 10/31/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    var photo: UIImage? {
        get {
            guard let data = self.rawPhoto as Data? else { return nil }
            
            return UIImage(data: data)
        }
        set {
            guard let photo = newValue else { return }
            self.rawPhoto = UIImagePNGRepresentation(photo) as NSData?
        }
    }
    
    convenience init?(category: Int64, formalTag: Int64, photo: UIImage?, weatherTag: Int64) {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return nil }
        
        self.init(entity: Item.entity(), insertInto: context)
        
        self.category = category
        self.formalTag = formalTag
        self.photo = photo
        self.weatherTag = weatherTag
        
    }

}
