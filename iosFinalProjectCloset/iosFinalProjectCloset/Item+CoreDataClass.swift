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
    
    convenience init?(category: Int64, formalTag: Int64, photo: Int64, weatherTag: Int64) {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return nil }
        
        self.init(entity: Item.entity(), insertInto: context)
        
        self.category = category
        self.formalTag = formalTag
        self.photo = photo
        self.weatherTag = weatherTag
        
    }

}
